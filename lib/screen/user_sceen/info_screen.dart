import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';
import 'package:lichvannien/screen/user_sceen/ChangePassword.dart';
import 'package:lichvannien/screen/user_sceen/update_info_screen.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _uid = '';
  String _name = '';
  //DateTime _date = DateTime.now();
  String _email = '';
  String _phone = '';
  String _gt = '';
  String _formattedDate = '';
  void getData() async {
    User? user = _auth.currentUser;
    _uid = user!.uid;
    //print('TAnnnnnnn ${user.email}');
    final DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(_uid).get();
    setState(() {
      _name = userDoc.get('name');
      //_date = userDoc.get('birthday').toDate();
      _email = userDoc.get('email');
      _phone = userDoc.get('phone');
      _gt = userDoc.get('gt');
      _formattedDate = userDoc.get('birthday');
      //_formattedDate = DateFormat('dd/MM/yyyy').format(_date);
    });

    //print('TAnnnnnnn ${_name}');
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  Widget boxBox(String text, String text2, String text3) {
    return SizedBox(
      width: 278,
      child: TextFormField(
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
          hintText: text3,
          label: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: const TextStyle(fontSize: 16),
              ).tr(),
              Text(
                text2,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontStyle: FontStyle.italic),
              ).tr(),
            ],
          ),
          enabled: false,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xffFBBA95),
        title: Text(
          'account_info',
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 339,
                width: 330,
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
                    border: Border.all(color: Colors.white, width: 0.3),
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    boxBox('name', _name, 'Mời bạn nhập họ và tên.'),
                    boxBox('date', _formattedDate,
                        'Mời bạn nhập tuổi của bạn.'),
                    boxBox('sex', _gt.toString(), 'Mời bạn nhập.'),
                    boxBox('Email', _email, 'Mời bạn nhập email.'),
                    boxBox('number_phone', _phone.toString(),
                        'MỜi bạn nhập số điện thoại.'),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                height: 40,
                width: 100,
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
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const UpdateInfoScreen(),
                        ));
                  },
                  child: const Center(
                      child: Image(
                          height: 21,
                          width: 21,
                          image: AssetImage('assets/icons/update.png'))),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                height: 40,
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
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ChangePassword(),
                        ));
                  },
                  child:  Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'change_password',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ).tr()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
