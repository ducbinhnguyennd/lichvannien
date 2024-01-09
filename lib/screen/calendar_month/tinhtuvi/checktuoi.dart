import 'package:easy_localization/easy_localization.dart';

String getCheckTuoi(String tuoi) {
  print('tanvlog: $tuoi');
  if (tuoi == 'khi'.tr()) {
    return 'assets/images/khi.png';
  } else if (tuoi == 'ga'.tr()) {
    return 'assets/images/ga.png';
  } else if (tuoi == 'cho'.tr()) {
    return 'assets/images/cho.png';
  } else if (tuoi == 'lon'.tr()) {
    return 'assets/images/lownj.png';
  } else if (tuoi == 'chuot'.tr()) {
    return 'assets/images/chuot.png';
  } else if (tuoi == 'trau'.tr()) {
    return 'assets/images/trau.png';
  } else if (tuoi == 'cop'.tr()) {
    return 'assets/images/ho.png';
  } else if (tuoi == 'mao'.tr()) {
    return 'assets/images/meo.png';
  } else if (tuoi == 'rong'.tr()) {
    return 'assets/images/rong.png';
  } else if (tuoi == 'ran'.tr()) {
    return 'assets/images/ran.png';
  } else if (tuoi == 'ngua'.tr()) {
    return 'assets/images/ngua.png';
  } else if (tuoi == 'de'.tr()) {
    return 'assets/images/de.png';
  } else {
    return 'assets/images/back.png';
  }
}
