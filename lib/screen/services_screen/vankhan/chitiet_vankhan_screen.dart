import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:lichvannien/model/Data/DataVanKhan.dart';
import 'package:lichvannien/model/ReadData/ModelVanKhan.dart';
import 'package:lichvannien/screen/services_screen/vankhan/chitiet.dart';

class ChiTietVanKhanScreen extends StatefulWidget {
  const ChiTietVanKhanScreen(
      {super.key, required this.loai, required this.check});
  final String loai;
  final String check;

  @override
  State<ChiTietVanKhanScreen> createState() => _ChiTietVanKhanScreenState();
}

class _ChiTietVanKhanScreenState extends State<ChiTietVanKhanScreen> {
  Widget listChiTiet(
      String ten, String gioithieu, String samle, String vankhan) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChiTiet(
                      ten: ten,
                      gioithieu: gioithieu,
                      samle: samle,
                      vankhan: vankhan,
                    )));
      },
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.black.withOpacity(0.2),
              //     offset: const Offset(0, 3),
              //     blurRadius: 7,
              //     spreadRadius: 5,
              //   ),
              // ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(width: 0.4, color: Colors.black),
            ),
            child: Row(
              children: [
                const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Image(
                      image: AssetImage('assets/images/vankhan.jpg'),
                    )),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            ten,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700),
                          ).tr(),
                        ),
                        Text(
                          gioithieu,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        ).tr()
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  List<ItemModel> list = [];

  @override
  Widget build(BuildContext context) {
    List<ItemModel> listVanKhan =
        itemList.where((element) => element.loai == widget.check).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffFBBA95),
        automaticallyImplyLeading: false,
        title: Text(
          'prayer_text',
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
        child: Container(
          padding: const EdgeInsets.all(20),
          //alignment: Alignment.bottomLeft,
          child: ListView.builder(
            itemCount: listVanKhan.length,
            itemBuilder: (context, index) {
              return listChiTiet(
                listVanKhan[index].ten.tr(),
                listVanKhan[index].gioithieu.tr(),
                listVanKhan[index].samle.tr(),
                listVanKhan[index].vankhan.tr(),
              );
            },
          ),
        ),
      ),
    );
  }
}
