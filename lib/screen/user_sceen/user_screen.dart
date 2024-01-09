import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:lichvannien/localization_checker.dart';
import 'package:lichvannien/screen/auth/main_screen.dart';
import 'package:lichvannien/screen/login/login_screen.dart';
import 'package:lichvannien/screen/user_sceen/info_screen.dart';
import 'package:lichvannien/screen/user_sceen/nap_screen.dart';
import 'package:lichvannien/screen/user_sceen/referralcode.dart';
import 'package:easy_localization/easy_localization.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

Widget turnoff(Function() onTap, String text) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xffF27E3C),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        )
      ],
    ),
  );
}

Widget customButton(
  Image image,
  Function() onTap,
  String chucnang,
) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(5),
            child: Container(
              child: image,
            ),
          ),
          Text(
            chucnang,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ).tr(),
        ],
      ),
    ),
  );
}

class _UserScreenState extends State<UserScreen>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin<UserScreen> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  User? user = FirebaseAuth.instance.currentUser;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _uid = '';
  String _name = '';
  bool isLightTheme = true;
  bool isLoading = true;

  Future<void> checkUserData(String userId) async {
    final DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    if (userDoc.exists) {
      // Người dùng có dữ liệu, hiển thị màn hình người dùng.
      setState(() {
        isLoading = false; // Người dùng có dữ liệu, không cần tải nữa.
      });
    } else {
      // Người dùng không có dữ liệu, chuyển hướng đến màn hình đăng nhập.
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ));
    }
  }

  void getData() async {
    User? user = _auth.currentUser;
    _uid = user?.uid ?? 'null';
    final DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(_uid).get();
    setState(() {
      _name = userDoc.get('name');
      isLoading = false;
    });
  }

  void deleteFirebaseAuthUser() async {
    User? user = FirebaseAuth.instance.currentUser;

    try {
      // Xóa tài khoản FireAuth
      await user?.delete();

      // Xóa dữ liệu người dùng
      deleteUserData(user?.uid ?? 'null');
    } catch (e) {
      // Xử lý ngoại lệ khi xóa tài khoản gặp lỗi
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          content:
              Center(child: Text('Đã xảy ra lỗi. Vui lòng đăng nhập lại.')),
        ),
      );
    }
  }

  void deleteUserData(String userId) async {
    String collectionPath = 'users';
    String documentPath = '$collectionPath/$userId';
    DocumentReference documentRef =
        FirebaseFirestore.instance.doc(documentPath);

    try {
      // Xóa tài liệu trong Firestore
      await documentRef.delete();
    } catch (e) {
      // Xử lý ngoại lệ khi xóa dữ liệu gặp lỗi
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Center(child: Text('Đã xảy ra lỗi.')),
        ),
      );
    }
  }

  Future<void> subscribeToTopic(String yourTopicName) async {
    String topic = yourTopicName;

    await _firebaseMessaging.subscribeToTopic(topic);
    //print('Đã đăng ký thiết bị vào chủ đề: $topic');
  }

  @override
  void initState() {
    getData();
    // checkscreen();
    checkUserData(_uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;

    // final themeProvider = Provider.of<ThemeProvider>(context);
    // final provider = Provider.of<ThemeProvider>(context, listen: false);

    return _name.isEmpty
        ? LoginScreen()
        : Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: const Color(0xffF7E3D7),
              title: Row(
                children: [
                  const Image(
                      height: 40,
                      width: 40,
                      image: AssetImage('assets/icons/anh.png')),
                  const SizedBox(
                    width: 20,
                  ),
                  isLoading // Kiểm tra trạng thái tải
                      ? const CircularProgressIndicator()
                      : Text(
                          _name,
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        ),
                ],
              ),
            ),
            body: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/backgroud.jpg'),
                    fit: BoxFit.cover),
              ),
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    isLoading // Kiểm tra trạng thái tải
                        ? const CircularProgressIndicator()
                        : Stack(
                            alignment: Alignment.center,
                            children: [
                              Column(
                                children: [
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Center(
                                    child: Container(
                                      height: (screenHeight * 8 / 100),
                                      width: 340,
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.2),
                                              offset: const Offset(0, 3),
                                              blurRadius: 7,
                                              spreadRadius: 5,
                                            ),
                                          ],
                                          color: const Color(0xffFBBA95),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                              color: Colors.white, width: 0.3)),
                                      child: const Center(
                                          child: Text(
                                        '0',
                                        style: TextStyle(
                                            //color: isLightTheme ? Colors.white : Colors.black,,
                                            fontSize: 40,
                                            fontWeight: FontWeight.w400),
                                      )),
                                    ),
                                  ),
                                ],
                              ),
                              Positioned(
                                top: 10,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.yellow,
                                  ),
                                  height: 30,
                                  width: 100,
                                  child: Center(
                                      child: Text(
                                    "balance",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ).tr()),
                                ),
                              ),
                            ],
                          ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Container(
                        height: Platform.isIOS
                            ? (screenHeight * 55 / 100)
                            : (screenHeight * 55 / 97),
                        width: 340,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                offset: const Offset(0, 3),
                                blurRadius: 7,
                                spreadRadius: 5,
                              ),
                            ],
                            color: const Color(0xffFBBA95),
                            borderRadius: BorderRadius.circular(10),
                            border:
                                Border.all(color: Colors.white, width: 0.3)),
                        child: Column(
                          children: [
                            customButton(
                                const Image(
                                    height: 32,
                                    width: 32,
                                    image: AssetImage(
                                        'assets/icons/taikhoan.png')), () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const InfoScreen(),
                                  ));
                            }, 'account_info'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    customButton(
                                        const Image(
                                            height: 32,
                                            width: 32,
                                            image: AssetImage(
                                                'assets/icons/napxu.png')), () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const NapXuScreen(),
                                          ));
                                    }, 'load_cents'),
                                    customButton(
                                        const Image(
                                            height: 32,
                                            width: 32,
                                            image: AssetImage(
                                                'assets/icons/hotro.png')),
                                        () {},
                                        'support'),
                                    customButton(
                                        const Image(
                                            height: 32,
                                            width: 32,
                                            image: AssetImage(
                                                'assets/icons/danhgia.png')),
                                        () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                              backgroundColor:
                                                  const Color(0xffFCCEB3),
                                              title: const Center(
                                                  child: Text(
                                                'evaluate',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                              actions: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 40),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: const Color(
                                                          0xffF27E3C),
                                                    ),
                                                    child: const Padding(
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Image(
                                                              height: 50,
                                                              width: 50,
                                                              image: AssetImage(
                                                                  'assets/icons/Star.png')),
                                                          Image(
                                                              height: 50,
                                                              width: 50,
                                                              image: AssetImage(
                                                                  'assets/icons/Star.png')),
                                                          Image(
                                                              height: 50,
                                                              width: 50,
                                                              image: AssetImage(
                                                                  'assets/icons/Star.png')),
                                                          Image(
                                                              height: 50,
                                                              width: 50,
                                                              image: AssetImage(
                                                                  'assets/icons/Star.png')),
                                                          Image(
                                                              height: 50,
                                                              width: 50,
                                                              image: AssetImage(
                                                                  'assets/icons/Star.png')),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ));
                                        },
                                      );
                                    }, 'evaluate'),
                                    customButton(
                                        const Image(
                                            height: 32,
                                            width: 32,
                                            image: AssetImage(
                                                'assets/icons/dangxuat.png')),
                                        () {
                                      FirebaseAuth.instance.signOut();
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MainScreen()),
                                          (Route<dynamic> route) => false);
                                    }, 'log_out'),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    customButton(
                                        const Image(
                                            height: 32,
                                            width: 32,
                                            image: AssetImage(
                                                'assets/icons/gioithieu.png')),
                                        () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const ReferralCode(),
                                          ));
                                    }, 'referral_code'),
                                    customButton(
                                        const Image(
                                            height: 32,
                                            width: 32,
                                            image: AssetImage(
                                                'assets/icons/giaodien.png')),
                                        () {
                                      LocalizationChecker.changeLanguge(
                                          context);
                                    }, 'display'),
                                    customButton(
                                        const Image(
                                            height: 32,
                                            width: 32,
                                            image: AssetImage(
                                                'assets/icons/quangcao.png')),
                                        () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                              backgroundColor:
                                                  const Color(0xffFCCEB3),
                                              title: const Center(
                                                  child: Text(
                                                'Tắt tất cả quảng cáo\n khi sử dụng ứng dụng',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                              actions: [
                                                Center(
                                                  child: Column(
                                                    children: [
                                                      turnoff(() {
                                                        subscribeToTopic(
                                                            '${_uid}SUB1THANG');
                                                      }, '1 Tháng - 150 xu'),
                                                      turnoff(() {
                                                        subscribeToTopic(
                                                            '${_uid}SUB6THANG');
                                                      }, '6 Tháng - 350 xu'),
                                                      turnoff(() {
                                                        subscribeToTopic(
                                                            '${_uid}SUB12THANG');
                                                      }, '12 Tháng - 500 xu'),
                                                      turnoff(() {
                                                        subscribeToTopic(
                                                            '${_uid}SUBTRONDOI');
                                                      }, 'Trọn đời - 690 xu'),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ));
                                        },
                                      );
                                    }, 'turn_off_ads'),
                                    customButton(
                                        const Image(
                                            height: 32,
                                            width: 32,
                                            image: AssetImage(
                                                'assets/icons/xoatk.png')), () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            backgroundColor:
                                                const Color(0xffFCCEB3),
                                            title: Center(
                                                child: Text(
                                              '''question_delete''',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ).tr()),
                                            actions: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: turnoff(() {
                                                      Navigator.pop(context);
                                                    }, 'no'.tr()),
                                                  ),
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  Expanded(
                                                    child: turnoff(() {
                                                      deleteUserData(_uid);
                                                      deleteFirebaseAuthUser();
                                                      Navigator.of(context)
                                                          .pushAndRemoveUntil(
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          MainScreen()),
                                                              (Route<dynamic>
                                                                      route) =>
                                                                  false);
                                                    }, 'yes'.tr()),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }, 'delete_account'),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: (screenHeight * 7 / 100),
                      width: 340,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              offset: const Offset(0, 3),
                              blurRadius: 7,
                              spreadRadius: 5,
                            ),
                          ],
                          color: const Color(0xffFBBA95),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white, width: 0.3)),
                      child: GestureDetector(
                        onTap: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image(
                                height: 32,
                                width: 32,
                                image: AssetImage('assets/icons/nhanxu.png')),
                            Text(
                              'ads',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ).tr(),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: (screenHeight * 10 / 100),
                    )
                  ],
                ),
              ),
            ),
          );
  }

  @override
  bool get wantKeepAlive => true;
}
