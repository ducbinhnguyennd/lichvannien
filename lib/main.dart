import 'package:easy_localization/easy_localization.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lichvannien/screen/auth/main_screen.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FacebookAudienceNetwork.init();
  MobileAds.instance.initialize();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.subscribeToTopic("ALL");
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
        supportedLocales: [Locale('en', 'US'), Locale('vi', 'VN')],
        path:
            'assets/translations', // <-- change the path of the translation files
        fallbackLocale: Locale('en', 'US'),
        child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'Lịch Vạn Niên',
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}
