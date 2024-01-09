import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lichvannien/screen/auth/main_screen.dart';
//import 'package:lichvannien/helpers/testparseDaTa.dart';
import 'package:lichvannien/screen/login/forgot_pw_screen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:lichvannien/screen/login/register_screen.dart';

class LoginScreen extends StatefulWidget {
  // final VoidCallback showRegisterScreen;
  // const LoginScreen({super.key, required this.showRegisterScreen});
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  bool _isLoggingIn = false;
  final formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  // Future singIn() async {
  //   final isValid = formKey.currentState!.validate();
  //   if (!isValid) return;
  //   setState(() {
  //     _isLoggingIn = true; // Đang thực hiện đăng nhập

  //   });

  //   try {
  //     await FirebaseAuth.instance.signInWithEmailAndPassword(
  //         email: _emailController.text.trim(),
  //         password: _passwordController.text.trim());
  //     setState(() {
  //       _isLoggingIn = false; // Đã hoàn thành đăng nhập
  //     });
  //   } on FirebaseAuthException {
  //     setState(() {
  //       _isLoggingIn = false;
  //     });
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //           behavior: SnackBarBehavior.floating,
  //           content: Center(child: Text('Wrong account or password'))),
  //     );
  //   }
  // }
  Future singIn() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    setState(() {
      _isLoggingIn = true; // Đang thực hiện đăng nhập
    });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
      setState(() {
        _isLoggingIn = false; // Đã hoàn thành đăng nhập
      });
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => MainScreen()),
          (Route<dynamic> route) => false);
    } on FirebaseAuthException {
      setState(() {
        _isLoggingIn = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Center(child: Text('Sai tài khoản hoặc mật khẩu'))),
      );
    }
  }

  @override
  void dispose() {
    FocusScope.of(context).unfocus();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  //   Widget _buildLoginApple() {
  //   return GestureDetector(
  //     onTap: () {
  //       Navigator.push(
  //                     context,
  //                     MaterialPageRoute(
  //                       builder: (context) => Test123(),
  //                     ),);
  //     },
  //     child: Container(
  //       decoration:BoxDecoration(
  //         borderRadius:BorderRadius.circular(12),
  //         border: Border.all(color:Colors.white10)
  //       ),

  //       child: Padding(
  //         padding: EdgeInsets.all(10),
  //         child: Row(
  //           children: [

  //             SizedBox(
  //               width: 50,
  //             ),
  //             Text(
  //               'Đăng nhập với Apple',
  //               style: TextStyle(
  //                   fontWeight: FontWeight.w700,
  //                   fontSize: 14,
  //                   color: Colors.black),
  //             ),
  //           ],
  //         ),
  //       ),

  //     ),

  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 75,
                  ),
                  const Text(
                    'Welcome to the perpetual calendar',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.red,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (email) =>
                            email != null && !EmailValidator.validate(email)
                                ? 'Please enter gmail!'
                                : null,
                        controller: _emailController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.white,
                                ),
                                borderRadius: BorderRadius.circular(20)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 55, 129, 203)),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            hintText: 'Gmail',
                            fillColor: Colors.grey[200],
                            filled: true,
                            prefixIcon: Padding(
                              padding:
                                  const EdgeInsets.only(right: 20, left: 10),
                              child: Image.asset(
                                'assets/icons/gmail.png',
                                width: 30,
                                height: 30,
                              ),
                            )),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) => value != null && value.length < 6
                            ? 'Too short, please no more than 6 characters.'
                            : null,
                        obscureText: _obscureText,
                        controller: _passwordController,
                        decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              child: Icon(_obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                            ),
                            border: InputBorder.none,
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.white,
                                ),
                                borderRadius: BorderRadius.circular(20)),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.deepPurple),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            hintText: 'Password',
                            fillColor: Colors.grey[200],
                            filled: true,
                            prefixIcon: Padding(
                              padding:
                                  const EdgeInsets.only(right: 20, left: 10),
                              child: Image.asset(
                                'assets/icons/pw.png',
                                width: 30,
                                height: 30,
                              ),
                            )),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ForgotPassWordScreen()));
                          },
                          child: const Text(
                            'Forgot password?',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap:
                        // () {
                        //   parseData();
                        // },
                        _isLoggingIn ? null : singIn,
                    child: Container(
                      height: 50,
                      width: 176,
                      decoration: BoxDecoration(
                        color: const Color(0xffFCCDB3),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Center(
                        child: Text(
                          'Log in',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  //               InkWell(
                  //                 child: Text('alo'),
                  //                 onTap:() {
                  //                   AuthService.signInWithApple().then((value) =>{
                  //                Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => Test123(test: value,)),
                  // )
                  //               });
                  //                 },
                  //               ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Do not have an account ? ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        // onTap: widget.showRegisterScreen,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterScreen()),
                          );
                        },
                        child: const Text(
                          'Register now',
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
