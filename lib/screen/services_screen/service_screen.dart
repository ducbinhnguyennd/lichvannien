import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lichvannien/screen/services_screen/giaimong/giaimong_screen.dart';
import 'package:lichvannien/screen/services_screen/tuvihangngay_screen.dart';
import 'package:lichvannien/screen/services_screen/trondoi/tuvitrondoi_screen.dart';
import 'package:lichvannien/screen/services_screen/vankhan/vankhan_screen.dart';
import 'package:lichvannien/screen/services_screen/xemngaytot/xemngaytot_screen.dart';
import 'package:lichvannien/screen/services_screen/xinxam/xinxam_screen.dart';

class ServiceScreen extends StatefulWidget {
  const ServiceScreen({super.key});

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  List<Anh> image = [
    Anh(
        anh: '''assets/icons/tuvi.png''',
        text: 'daily_horoscope',
        Navi: TuViHangNgayScreen()),
    Anh(
        anh: '''assets/icons/trondoi.png''',
        text: 'lifetime',
        Navi: TuViTronDoiScreen()),
    Anh(anh: '''assets/icons/vankhan.png''', text: 'liturgy', Navi: VanKhan()),
    Anh(
        anh: '''assets/icons/ngaytot.png''',
        text: 'see_good_day',
        Navi: XemNgayTotScreen()),
    Anh(
        anh: '''assets/icons/xinxam.png''',
        text: 'tattoo_request',
        Navi: XinXamScreen()),
    Anh(
        anh: '''assets/icons/giaimong.png''',
        text: 'dream_interpretation',
        Navi: GiaiMongScreen()),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xffF7E3D7),
        title: Text('Service'.tr(),
            style: TextStyle(
              color: Colors.black,
            )),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/backgroud.jpg'),
              fit: BoxFit.cover),
        ),
        child: GridView.builder(
          itemCount: image.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 0.85),
          itemBuilder: (BuildContext context, int index) {
            return TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => image[index].Navi,
                      ));
                },
                child: Stack(children: [
                  Image(
                    image: AssetImage(image[index].anh),
                  ),
                  Positioned(
                      bottom: 50,
                      left: 40,
                      right: 0,
                      child: Text(
                        image[index].text.tr(),
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      )),
                ]));
          },
        ),
      ),
    );
  }
}

class Anh {
  final String anh;
  final String text;
  final Widget Navi;
  Anh({
    required this.anh,
    required this.text,
    required this.Navi,
  });
}
