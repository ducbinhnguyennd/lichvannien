import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _newPasswordController = TextEditingController();

  bool _isLoading = false;
  String _errorMessage = '';

  void _changePassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _errorMessage = '';
      });

      try {
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          AuthCredential credential = EmailAuthProvider.credential(
            email: user.email!,
            password: _passwordController.text.trim(),
          );

          // Xác thực mật khẩu cũ
          await user.reauthenticateWithCredential(credential);

          // Thay đổi mật khẩu
          await user.updatePassword(_newPasswordController.text.trim());

          setState(() {
            _isLoading = false;
            _errorMessage = '';
          });

          // Hiển thị thông báo thành công
          // ignore: use_build_context_synchronously
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Thành công'),
                content: const Text('Mật khẩu đã được thay đổi.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      } catch (error) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Sai mật khẩu, vui lòng nhập lại';
        });
        //print('Change password error: $error');
      }
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xffFBBA95),
        title: Text(
          'change_password',
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
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/backgroud.jpg'),
              fit: BoxFit.cover),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'old_password'.tr()),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'please_old_password'.tr();
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _newPasswordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'new_password'.tr()),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'please_new_password'.tr();
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
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
                  onTap: _isLoading ? null : _changePassword,
                  child: Center(child: Text('change_password').tr()),
                ),
              ),
              // ElevatedButton(
              //   onPressed: _isLoading ? null : _changePassword,
              //   child: const Text('Đổi mật khẩu'),
              // ),
              const SizedBox(height: 8.0),
              Text(
                _errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
