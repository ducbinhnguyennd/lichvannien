import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPassWordScreen extends StatefulWidget {
  const ForgotPassWordScreen({super.key});

  @override
  State<ForgotPassWordScreen> createState() => _ForgotPassWordScreenState();
}

class _ForgotPassWordScreenState extends State<ForgotPassWordScreen> {
  final _emailController = TextEditingController();
  Future passwpordReset() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: _emailController.text.trim(),
      );
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Center(
                child: Text('Vui lòng đăng nhập Email để thay đổi mật khẩu.'))),
      );
    } on FirebaseAuthException {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Center(child: Text('Email không chính xác'))),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xffFBBA95),
        title: const Text(
          'THÔNG TIN TÀI KHOẢN',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
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
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(0.8, 1),
            colors: <Color>[
              Color(0xffF7E3D7),
              Color(0xffFFA877),
              Color(0xffFBBA95),
              Color(0xffEF6518),
            ],
            tileMode: TileMode.mirror,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Vui lòng nhập Email....',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (email) =>
                      email != null && !EmailValidator.validate(email)
                          ? 'Email chưa đúng!'
                          : null,
                  controller: _emailController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(12)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.deepPurple),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: 'Email',
                    fillColor: Colors.grey[200],
                    filled: true,
                  ),
                )),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: passwpordReset,
              child: Container(
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
                  border: Border.all(color: Colors.white, width: 0.3),
                ),
                child: const Center(
                  child: Text(
                    'Xác nhận',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
