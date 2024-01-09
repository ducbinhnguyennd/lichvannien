import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lichvannien/screen/calendar_month/widget/GioLucNham.dart';

class CheckLucNham extends StatelessWidget {
  const CheckLucNham({super.key, required this.lucnhamngay});

  final String lucnhamngay;
  @override
  Widget build(BuildContext context) {
    if (lucnhamngay == 'daian') {
      return GioLucNham(
        text: 'text_daian'.tr(),
        text1: 'text1_daian'.tr(),
        text2: 'text2_daian'.tr(),
        text3: 'text3_daian'.tr(),
        text4: 'text4_daian'.tr(),
        text5: 'text5_daian'.tr(),
      );
    } else if (lucnhamngay == 'luulien'.tr()) {
      return  GioLucNham(
        text: 'text_luulien'.tr(),
        text1: 'text1_luulien'.tr(),
        text2: 'text2_luulien'.tr(),
        text3: 'text3_luulien'.tr(),
        text4: 'text4_luulien'.tr(),
        text5: 'text5_luulien'.tr(),
      );
    } else if (lucnhamngay == 'tochuy'.tr()) {
      return  GioLucNham(
        text: 'text_tochy'.tr(),
        text1: 'text1_tochy'.tr(),
        text2: 'text2_tochy'.tr(),
        text3: 'text3_tochy'.tr(),
        text4: 'text4_tochy'.tr(),
        text5: 'text5_tochy'.tr(),
      );
    } else if (lucnhamngay == 'xichkhau'.tr()) {
      return  GioLucNham(
        text: 'text_xichkhau'.tr(),
        text1: 'text1_xichkhau'.tr(),
        text2: 'text2_xichkhau'.tr(),
        text3: 'text3_xichkhau'.tr(),
        text4: 'text4_xichkhau'.tr(),
        text5: 'text5_xichkhau'.tr(),
      );
    } else if (lucnhamngay == 'tieucat'.tr()) {
      return  GioLucNham(
        text: 'text_tieucat'.tr(),
        text1: 'text1_tieucat'.tr(),
        text2: 'text2_tieucat'.tr(),
        text3: 'text3_tieucat'.tr(),
        text4: 'text4_tieucat'.tr(),
        text5: 'text5_tieucat'.tr(),
      );
    } else {
      return  GioLucNham(
        text: 'text'.tr(),
        text1: 'text1'.tr(),
        text2: 'text2'.tr(),
        text3: 'text3'.tr(),
        text4: 'text4'.tr(),
        text5: 'text5'.tr(),
      );
    }
  }
}

