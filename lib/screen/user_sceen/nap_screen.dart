import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class NapXuScreen extends StatefulWidget {
  const NapXuScreen({super.key});

  @override
  State<NapXuScreen> createState() => _NapXuScreenState();
}

class _NapXuScreenState extends State<NapXuScreen> {
  String dropdownValue = list.first;
  String dropdownValue1 = list1.first;
  String dropdownValue2 = list2.first;

  @override
  Widget build(BuildContext context) {
    Widget boxBox(String text, Widget widget) {
      return Container(
        width: 339,
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
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white, width: 0.3)),
        child: ExpansionTile(
          maintainState: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Image(
                  height: 34,
                  width: 34,
                  image: AssetImage('assets/icons/napxu.png')),
              Text(text),
            ],
          ),
          children: [widget],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xffFBBA95),
        title: Text(
          'load_cents'.tr(),
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
          image: DecorationImage(
              image: AssetImage('assets/images/backgroud.jpg'),
              fit: BoxFit.cover),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'please_choose',
                  style: TextStyle(fontSize: 16),
                ).tr(),
                const SizedBox(
                  height: 30,
                ),
                boxBox(
                  'mobile_recharge'.tr(),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text('card_type').tr(),
                          SizedBox(
                            height: 40,
                            width: 170,
                            child: DropdownButton(
                              dropdownColor: const Color(0xffFBBA95),
                              value: dropdownValue,
                              icon: const Icon(Icons.arrow_drop_down),
                              elevation: 16,
                              style: const TextStyle(color: Colors.deepPurple),
                              onChanged: (String? value) {
                                setState(() {
                                  dropdownValue = value!;
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
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text('price').tr(),
                          SizedBox(
                            height: 40,
                            width: 170,
                            child: DropdownButton(
                              dropdownColor: const Color(0xffFBBA95),
                              value: dropdownValue1,
                              icon: const Icon(Icons.arrow_drop_down),
                              elevation: 16,
                              style: const TextStyle(color: Colors.deepPurple),
                              onChanged: (String? value) {
                                setState(() {
                                  dropdownValue1 = value!;
                                });
                              },
                              items: list1.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                       Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('seri').tr(),
                          SizedBox(
                            height: 40,
                            width: 170,
                            child: TextField(),
                          )
                        ],
                      ),
                       Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('number').tr(),
                          SizedBox(
                            height: 40,
                            width: 170,
                            child: TextField(),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                        onTap: () {},
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
                                border: Border.all(
                                    color: Colors.white, width: 0.3)),
                            child: Center(
                                child: Text(
                              'load_cents',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w700),
                            ).tr())),
                      ),
                      const SizedBox(
                        height: 17,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                boxBox(
                    'deposit_bank'.tr(),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text('choose_bank').tr(),
                            SizedBox(
                              height: 40,
                              width: 170,
                              child: DropdownButton(
                                dropdownColor: const Color(0xffFBBA95),
                                value: dropdownValue2,
                                icon: const Icon(Icons.arrow_drop_down),
                                elevation: 16,
                                style:
                                    const TextStyle(color: Colors.deepPurple),
                                onChanged: (String? value) {
                                  setState(() {
                                    dropdownValue2 = value!;
                                  });
                                },
                                items: list2.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text('price').tr(),
                            SizedBox(
                              height: 40,
                              width: 170,
                              child: DropdownButton(
                                dropdownColor: const Color(0xffFBBA95),
                                value: dropdownValue1,
                                icon: const Icon(Icons.arrow_drop_down),
                                elevation: 16,
                                style:
                                    const TextStyle(color: Colors.deepPurple),
                                onChanged: (String? value) {
                                  setState(() {
                                    dropdownValue1 = value!;
                                  });
                                },
                                items: list1.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        GestureDetector(
                          onTap: () {},
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
                                  border: Border.all(
                                      color: Colors.white, width: 0.3)),
                              child:  Center(
                                  child: Text(
                                'load_cents',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w700),
                              ).tr())),
                        ),
                        const SizedBox(
                          height: 17,
                        )
                      ],
                    )),
                const SizedBox(
                  height: 30,
                ),
                boxBox(
                    'momo'.tr(),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text('price').tr(),
                            SizedBox(
                              height: 40,
                              width: 170,
                              child: DropdownButton(
                                dropdownColor: const Color(0xffFBBA95),
                                value: dropdownValue1,
                                icon: const Icon(Icons.arrow_drop_down),
                                elevation: 16,
                                style:
                                    const TextStyle(color: Colors.deepPurple),
                                onChanged: (String? value) {
                                  setState(() {
                                    dropdownValue1 = value!;
                                  });
                                },
                                items: list1.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        GestureDetector(
                          onTap: () {},
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
                                  border: Border.all(
                                      color: Colors.white, width: 0.3)),
                              child: Center(
                                  child: Text(
                                'load_cents',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w700),
                              ).tr())),
                        ),
                        const SizedBox(
                          height: 17,
                        )
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

const List<String> list = <String>['Viettel', 'Vina', 'Mobi'];
 List<String> list1 = <String>[
  'choose_price'.tr(),
  '10.000',
  '20.000',
  '50.000',
  '100.000',
  '200.000',
  '500.000',
  '1.000.000'
];
const List<String> list2 = <String>['VCB', 'TCB', 'MB'];
