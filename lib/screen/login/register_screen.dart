import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:lichvannien/model/UserData.dart';
import 'package:lichvannien/screen/auth/main_screen.dart';
// import 'package:intl/intl.dart';

class RegisterScreen extends StatefulWidget {
  // final VoidCallback showLoginScreen;
  // const RegisterScreen({super.key, required this.showLoginScreen});
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _obscureText = true;
  final formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  //final _confirmPasswordController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _dateController = TextEditingController();
  final _maGtController = TextEditingController();
  // late DateTime _selectedDate;
  late String _gtController;
  Future signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      addUserDetails(
        _nameController.text.trim(),
        _phoneController.text.trim(),
        _emailController.text.trim(),
        _dateController.text.trim(),
        //_selectedDate,
        _gtController.trim(),
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      if (userCredential.user != null) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => MainScreen()),
            (Route<dynamic> route) => false);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: const Text('Account already exists.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }

  // bool passwordConfirm() {
  //   if (_passwordController.text.trim() ==
  //       _confirmPasswordController.text.trim()) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  Future addUserDetails(String name, String phone, String email,
      String birthday, String gt) async {
    //final birthday = DateFormat('dd/MM/yyyy').parse(_dateController.text.trim());
    final User? _auth = FirebaseAuth.instance.currentUser;
    final _uid = _auth!.uid;
    final docUser = FirebaseFirestore.instance.collection('users').doc(_uid);
    final user = UserData(
      uid: _uid,
      name: _nameController.text,
      birthday: _dateController.text,
      email: _emailController.text,
      phone: _phoneController.text,
      gt: _gtController,
    );
    final json = user.toJson();
    await docUser.set(json);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _gtController = "Male";
    // _selectedDate = DateTime.now();
    super.initState();
  }

  // Future<void> _selectDate(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: _selectedDate,
  //     firstDate: DateTime(1900),
  //     lastDate: DateTime.now(),
  //   );
  //   if (picked != null && picked != _selectedDate) {
  //     setState(() {
  //       _selectedDate = picked;
  //       _dateController.text = DateFormat('dd/MM/yyyy').format(_selectedDate);
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffFFA877),
        automaticallyImplyLeading: true,
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
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) => (value!.isEmpty ||
                                  !RegExp(r'^[a-zA-Záàảãạăắằẳẵặâấầẩẫậéèẻẽẹêếềểễệíìỉĩịóòỏõọôốồổỗộơớờởỡợúùủũụưứừửữựýỳỷỹỵ\s]+$')
                                      .hasMatch(value))
                              ? 'Please enter your first and last name!'
                              : null,
                          controller: _nameController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.white,
                                  ),
                                  borderRadius: BorderRadius.circular(20)),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              hintText: 'First and last name ',
                              fillColor: Colors.white,
                              filled: true,
                              prefixIcon: Padding(
                                padding:
                                    const EdgeInsets.only(right: 20, left: 10),
                                child: Image.asset(
                                  'assets/icons/hoten.png',
                                  width: 30,
                                  height: 30,
                                ),
                              )),
                        )),
                    const SizedBox(
                      height: 22,
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 25),
                    //   child: Container(
                    //     height: 50,
                    //     decoration: BoxDecoration(
                    //         color: Colors.white,
                    //         borderRadius: BorderRadius.circular(20),
                    //         border: Border.all(color: Colors.white)),
                    //     child: Row(
                    //       children: [
                    //         Padding(
                    //           padding: const EdgeInsets.only(right: 20, left: 10),
                    //           child: Image.asset(
                    //             'assets/icons/ngaysinh.png',
                    //             width: 30,
                    //             height: 30,
                    //           ),
                    //         ),
                    //         // const Text(
                    //         //   'Ngày/ Tháng / Năm ',
                    //         //   style: TextStyle(fontSize: 16),
                    //         // ),
                    //         InkWell(
                    //           onTap: () => _selectDate(context),
                    //           child: Container(
                    //             alignment: Alignment.center,
                    //             height: 40,
                    //             width: 200,
                    //             // decoration: BoxDecoration(
                    //             //   border: Border.all(color: Colors.grey),
                    //             //   borderRadius: BorderRadius.circular(5),
                    //             // ),
                    //             child: TextFormField(
                    //               //style: const TextStyle(fontSize: 16),
                    //               //textAlign: TextAlign.center,
                    //               enabled: false,
                    //               keyboardType: TextInputType.datetime,
                    //               controller: _dateController,
                    //               decoration: const InputDecoration(
                    //                 disabledBorder: InputBorder.none,
                    //                 contentPadding: EdgeInsets.zero,
                    //                 hintText: 'Ngày/ Tháng / Năm ',
                    //                 //  DateFormat('dd/MM/yyyy')
                    //                 //     .format(_selectedDate),
                    //                 //hintStyle: TextStyle(fontSize: 16),
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) => (value!.isEmpty ||
                                      !RegExp(r'^\d{2}/\d{2}/\d{4}$')
                                          .hasMatch(value)) &&
                                  value.length > 3
                              ? 'Please enter the correct format dd/mm/yyyy'
                              : null,
                          controller: _dateController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.white,
                                  ),
                                  borderRadius: BorderRadius.circular(20)),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              hintText: 'Day/ Month / Year ',
                              fillColor: Colors.white,
                              filled: true,
                              prefixIcon: Padding(
                                padding:
                                    const EdgeInsets.only(right: 20, left: 10),
                                child: Image.asset(
                                  'assets/icons/ngaysinh.png',
                                  width: 30,
                                  height: 30,
                                ),
                              )),
                        )),
                    const SizedBox(
                      height: 22,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (email) =>
                              email != null && !EmailValidator.validate(email)
                                  ? 'Gmail is not correct!'
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
                                borderSide:
                                    const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              hintText: 'Gmail ',
                              fillColor: Colors.white,
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
                      height: 22,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) => value != null &&
                                  value.length < 6
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
                                    const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              hintText: 'Password',
                              fillColor: Colors.white,
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
                      height: 22,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) => (value!.isEmpty ||
                                      !RegExp(r'^\d{3}-\d{3}-\d{4}$')
                                          .hasMatch(value)) &&
                                  value.length != 10
                              ? 'Please enter the phone number!'
                              : null,
                          controller: _phoneController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.white,
                                  ),
                                  borderRadius: BorderRadius.circular(20)),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              hintText: 'Phone number ',
                              fillColor: Colors.white,
                              filled: true,
                              prefixIcon: Padding(
                                padding:
                                    const EdgeInsets.only(right: 20, left: 10),
                                child: Image.asset(
                                  'assets/icons/phone.png',
                                  width: 30,
                                  height: 30,
                                ),
                              )),
                        )),
                    const SizedBox(
                      height: 22,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          // validator: (value) => (value!.isEmpty ||
                          //             !RegExp(r'^\d{3}-\d{3}-\d{4}$')
                          //                 .hasMatch(value)) &&
                          //         value.length != 10
                          //     ? 'Vui lòng Nhập đúng mã giới thiệu'
                          //     : null,
                          controller: _maGtController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.white,
                                  ),
                                  borderRadius: BorderRadius.circular(20)),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              hintText: 'Enter referral code if available!',
                              fillColor: Colors.white,
                              filled: true,
                              prefixIcon: Padding(
                                padding:
                                    const EdgeInsets.only(right: 20, left: 10),
                                child: Image.asset(
                                  'assets/icons/gt.png',
                                  width: 30,
                                  height: 30,
                                ),
                              )),
                        )),
                    // Padding(
                    //     padding: const EdgeInsets.symmetric(horizontal: 25),
                    //     child: TextFormField(
                    //       autovalidateMode: AutovalidateMode.onUserInteraction,
                    //       validator: (value) =>
                    //           // ignore: unrelated_type_equality_checks
                    //           value != null && value == _passwordController
                    //               ? 'Vui lòng nhập giống ở trên!!'
                    //               : null,
                    //       obscureText: _obscureText,
                    //       controller: _confirmPasswordController,
                    //       decoration: InputDecoration(
                    //           suffixIcon: Icon(_obscureText
                    //               ? Icons.visibility
                    //               : Icons.visibility_off),
                    //           border: InputBorder.none,
                    //           enabledBorder: OutlineInputBorder(
                    //               borderSide: const BorderSide(
                    //                 color: Colors.white,
                    //               ),
                    //               borderRadius: BorderRadius.circular(20)),
                    //           focusedBorder: OutlineInputBorder(
                    //             borderSide: const BorderSide(color: Colors.black),
                    //             borderRadius: BorderRadius.circular(20),
                    //           ),
                    //           hintText: 'Confirm Password',
                    //           fillColor: Colors.white,
                    //           filled: true,
                    //           prefixIcon: Padding(
                    //             padding:
                    //                 const EdgeInsets.only(right: 20, left: 10),
                    //             child: Image.asset(
                    //               'assets/icons/pw.png',
                    //               width: 30,
                    //               height: 30,
                    //             ),
                    //           )),
                    //     )),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    const SizedBox(
                      height: 44,
                    ),
                    GestureDetector(
                      onTap: (signUp),
                      child: Container(
                        height: 45,
                        width: 176,
                        decoration: BoxDecoration(
                          color: const Color(0xffFCCDB3),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Center(
                          child: Text(
                            'Register',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    //                   Row(
                    //                     mainAxisAlignment: MainAxisAlignment.center,
                    //                     children: [
                    //                       const Text(
                    //                         'Do you already have an account ? ',
                    //                         style: TextStyle(fontWeight: FontWeight.bold),
                    //                       ),
                    //                       GestureDetector(
                    //                         // onTap: widget.showLoginScreen,
                    //                         onTap:(){
                    //                            Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) =>  LoginScreen()),
                    // );
                    //                         },
                    //                         child: const Text(
                    //                           'Login Now',
                    //                           style: TextStyle(
                    //                               color: Colors.blue, fontWeight: FontWeight.bold),
                    //                         ),
                    //                       ),
                    //                     ],
                    //                   ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
