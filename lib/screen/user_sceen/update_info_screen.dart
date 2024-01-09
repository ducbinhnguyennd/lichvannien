import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';

import 'package:lichvannien/model/UserData.dart';

class UpdateInfoScreen extends StatefulWidget {
  const UpdateInfoScreen({super.key});

  @override
  State<UpdateInfoScreen> createState() => _UpdateInfoScreenState();
}

class _UpdateInfoScreenState extends State<UpdateInfoScreen> {
  String dropdownValue = list.first;
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _dateController = TextEditingController();
  //late DateTime _selectedDate;
  late String _gtController;

  void showIncompleteDataDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:  Text('notification').tr(),
          content:  Text('please_full').tr(),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('close').tr(),
            ),
          ],
        );
      },
    );
  }

  Future updateData() async {
    if (_nameController.text.isEmpty ||
      
        _gtController.isEmpty ||
        _emailController.text.isEmpty ||
        _phoneController.text.isEmpty) {
      showIncompleteDataDialog(context);
      return;
    }
    await FirebaseAuth.instance.currentUser!
        .updateEmail(_emailController.text.trim());
    addUserDetails(
      _nameController.text.trim(),
      _phoneController.text.trim(),
      _emailController.text.trim(),
      _dateController.text.trim(),
      //_selectedDate,
      _gtController.trim(),
    );
    // ignore: use_build_context_synchronously
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  Future addUserDetails(String firstname, String lastname, String email,
      String birthday, String gt) async {
    final User? auth = FirebaseAuth.instance.currentUser;
    final uid = auth!.uid;
    final docUser = FirebaseFirestore.instance.collection('users').doc(uid);
    final user = UserData(
      uid: uid,
      name: _nameController.text,
      birthday: _dateController.text,
      email: _emailController.text,
      phone: _phoneController.text,
      gt: _gtController,
    );
    final json = user.toJson();
    await docUser.set(json);
  }

  Widget boxBox(String? Function(String?)? key, TextEditingController controler,
      String hint, String label) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: key,
        controller: controler,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
          hintText: hint.tr(),
          label: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 16),
              ).tr(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    _gtController = dropdownValue;
    //_selectedDate = DateTime.now();
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
                child: Form(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      boxBox(
                          (value) => (value!.isEmpty ||
                                  !RegExp(r'^[a-zA-Záàảãạăắằẳẵặâấầẩẫậéèẻẽẹêếềểễệíìỉĩịóòỏõọôốồổỗộơớờởỡợúùủũụưứừửữựýỳỷỹỵ\s]+$')
                                      .hasMatch(value))
                              ? 'please_name'
                              : null,
                          _nameController,
                          'please_name',
                          'name'),
                      // boxBox(
                      //     (value) => (value!.isEmpty ||
                      //             !RegExp(r'^\d{2}/\d{2}/\d{4}$')
                      //                 .hasMatch(value))
                      //         ? 'Vui lòng nhập đúng định dạng dd/mm/yyyy'
                      //         : null,
                      //     _nameController,
                      //     'Mời bạn nhập ngày sinh.',
                      //     'date'),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 20, right: 20),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       const Text(
                      //         'Ngày sinh',
                      //         style: TextStyle(
                      //             fontSize: 16, color: Colors.black54),
                      //       ),
                      //       InkWell(
                      //         onTap: () => _selectDate(context),
                      //         child: Container(
                      //           alignment: Alignment.center,
                      //           height: 40,
                      //           width: 120,
                      //           decoration: BoxDecoration(
                      //             border: Border.all(color: Colors.grey),
                      //             borderRadius: BorderRadius.circular(5),
                      //           ),
                      //           child: TextFormField(
                      //             style: const TextStyle(fontSize: 16),
                      //             textAlign: TextAlign.center,
                      //             enabled: false,
                      //             keyboardType: TextInputType.datetime,
                      //             controller: _dateController,
                      //             decoration: InputDecoration(
                      //               disabledBorder: InputBorder.none,
                      //               contentPadding: EdgeInsets.zero,
                      //               hintText: DateFormat('dd/MM/yyyy')
                      //                   .format(_selectedDate),
                      //               hintStyle: const TextStyle(fontSize: 16),
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // const Padding(
                      //   padding: EdgeInsets.only(left: 20, right: 20),
                      //   child: Divider(
                      //     height: 1,
                      //     thickness: 1.1,
                      //     endIndent: 0,
                      //     color: Colors.black26,
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                             Text(
                              'sex',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.black54),
                            ).tr(),
                            DropdownButton(
                              dropdownColor: const Color(0xffFBBA95),
                              value: dropdownValue,
                              icon: const Icon(Icons.arrow_drop_down),
                              elevation: 16,
                              style: const TextStyle(color: Colors.deepPurple),
                              onChanged: (String? value) {
                                setState(() {
                                  dropdownValue = value!;
                                  _gtController = dropdownValue;
                                });
                              },
                              items: list.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Divider(
                          height: 1,
                          thickness: 1.1,
                          endIndent: 0,
                          color: Colors.black26,
                        ),
                      ),
                      boxBox(
                        (email) =>
                            email != null && !EmailValidator.validate(email)
                                ? 'Email chưa đúng!'
                                : null,
                        _emailController,
                        'Mời bạn nhập email.',
                        'Email',
                      ),
                      boxBox(
                        (value) => (value!.isEmpty ||
                                    !RegExp(r'^\d{3}-\d{3}-\d{4}$')
                                        .hasMatch(value)) &&
                                value.length != 10
                            ? 'please_phone'
                            : null,
                        _phoneController,
                        'please_phone',
                        'number_phone'.tr(),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: updateData,
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
                  child:  Center(
                    child: Text(
                      'update',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ).tr(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

 List<String> list = <String>['male'.tr(), 'female'.tr()];
