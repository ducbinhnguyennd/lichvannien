import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:lichvannien/helpers/assets_helpers.dart';
import 'package:lichvannien/screen/calendar_month/calendar_month_screen.dart';
import 'package:lichvannien/screen/home_screen.dart';
import 'package:lichvannien/screen/user_sceen/user_screen.dart';

import 'package:lichvannien/screen/services_screen/service_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    //String deviceToken = await getDeviceToken();
    // print("Token");
    // print(deviceToken);
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      //String? title = message.notification!.title;
      //String? body = message.notification!.body;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // Số lượng tab
      child: Scaffold(
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            const HomeScreen(),
            const CalendarMonthScreen(),
            const ServiceScreen(),
            UserScreen(),
          ],
        ),
        bottomNavigationBar: Container(
          height: MediaQuery.of(context).size.height / 11,
          color: Color(0xffFBBA95),
          child: TabBar(
            indicatorColor: Colors.orange,
            indicatorWeight: 5.0,
            tabs: [
              Tab(
                icon: Image.asset(
                  AssetsHelper.iconHome,
                  height: 29,
                  width: 27,
                ),
                text: "Homepage".tr(),
              ),
              Tab(
                icon: Image.asset(
                  AssetsHelper.iconLich,
                  height: 29,
                  width: 27,
                ),
                text: "Month_calendar".tr(),
              ),
              Tab(
                icon: Image.asset(
                  AssetsHelper.iconDichVu,
                  height: 29,
                  width: 27,
                ),
                text: "Service".tr(),
              ),
              Tab(
                icon: Image.asset(
                  AssetsHelper.iconUser,
                  height: 29,
                  width: 27,
                ),
                text: "Account".tr(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future getDeviceToken() async {
    FirebaseMessaging _firebaseMessage = FirebaseMessaging.instance;
    String? deviceToken = await _firebaseMessage.getToken();
    return (deviceToken == null) ? "" : deviceToken;
  }
}
