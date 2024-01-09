import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ReferralCode extends StatefulWidget {
  const ReferralCode({super.key});

  @override
  State<ReferralCode> createState() => _ReferralCodeState();
}

class _ReferralCodeState extends State<ReferralCode> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _uid = '';
  String _phone = '';
  void getData() async {
    User? user = _auth.currentUser;
    _uid = user!.uid;
    final DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(_uid).get();
    setState(() {
      _phone = userDoc.get('phone');
    });
  }

  void copyToClipboard() {
    Clipboard.setData(ClipboardData(text: _phone));
    // Hiển thị thông báo hoặc thực hiện hành động khác sau khi đã sao chép thành công.
    ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Center(child: Text('copied').tr())),
    );
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xffFBBA95),
        title: const Text(
          'referral_code',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ).tr(),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_outlined,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/backgroud.jpg'),
              fit: BoxFit.cover),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 150),
            child: Column(
              children: [
                const Image(
                    height: 180,
                    width: 180,
                    image: AssetImage('assets/images/magioithieu.png')),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 50,
                  width: 200,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          offset: const Offset(0, 3),
                          blurRadius: 7,
                          spreadRadius: 5,
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.black,
                        width: 0.4,
                        style: BorderStyle.solid,
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        _phone,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                          onTap: copyToClipboard, child: const Icon(Icons.copy))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                RichText(
                  text:  TextSpan(
                      text: 'share_code'.tr(),
                      style: TextStyle(color: Colors.black, fontSize: 12),
                      // children: [
                      //   TextSpan(
                      //       text: ' 50 xu',
                      //       style: TextStyle(
                      //           fontSize: 14, fontWeight: FontWeight.w400))
                      // ]
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
