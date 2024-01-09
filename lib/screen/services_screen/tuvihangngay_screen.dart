//import 'dart:math';

import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lichvannien/model/Data/DataTuViHangNgay.dart';
import 'package:lichvannien/model/ReadData/ModelTuViHangNgay.dart';
import 'package:lichvannien/utils/date_utils.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

class TuViHangNgayScreen extends StatefulWidget {
  const TuViHangNgayScreen({super.key});

  @override
  State<TuViHangNgayScreen> createState() => _TuViHangNgayScreenState();
}

class _TuViHangNgayScreenState extends State<TuViHangNgayScreen> {
  BannerAd? _bannerAd;
  String _adUnitId = Platform.isAndroid
      ? 'ca-app-pub-1746687537594966/7997874829'
      : 'ca-app-pub-1746687537594966/7952028399';
  final ValueNotifier<double> fontSizeNotifier = ValueNotifier<double>(15);
  DateTime selectedDate = DateTime.now();
  int _focusedIndex = 0;
  void increaseFontSize() {
    if (fontSizeNotifier.value < 24.0) {
      fontSizeNotifier.value += 1.0;
    }
  }

  void decreaseFontSize() {
    if (fontSizeNotifier.value > 12.0) {
      fontSizeNotifier.value -= 1.0;
    }
  }

  @override
  void initState() {
    _loadAd();
   
    super.initState();
    FacebookAudienceNetwork.init(
      testingId: 'a77955ee-3304-4635-be65-81029b0f5201',
      iOSAdvertiserTrackingEnabled: true,
    );
  }

  //region: area ads
  /// Loads and shows a banner ad.
  ///
  /// Dimensions of the ad are determined by the AdSize class.
  void _loadAd() async {
    // set banner ads id
    if (kDebugMode) {
      // for test id ads banner
      _adUnitId = Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/6300978111'
          : 'ca-app-pub-3940256099942544/2934735716';
    }
    BannerAd(
      adUnitId: _adUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          if (kDebugMode) {
            print('_alexTR_logging_: ads onAdLoaded called!');
          }

          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, err) {
          if (kDebugMode) {
            print('_alexTR_logging_: ads onAdFailedToLoad called!');
          }
          ad.dispose();
        },
        // Called when an ad opens an overlay that covers the screen.
        onAdOpened: (Ad ad) {
          if (kDebugMode) {
            print('_alexTR_logging_: ads onAdOpened called!');
          }
        },
        // Called when an ad removes an overlay that covers the screen.
        onAdClosed: (Ad ad) {
          if (kDebugMode) {
            print('_alexTR_logging_: ads onAdClosed called!');
          }
        },
        // Called when an impression occurs on the ad.
        onAdImpression: (Ad ad) {
          if (kDebugMode) {
            print('_alexTR_logging_: ads onAdImpression called!');
          }
        },
      ),
    ).load();
  }

  _buildBannerAds() {
    return _bannerAd == null
        ? Container()
        : Align(
            alignment: Alignment.bottomCenter,
            child: Platform.isAndroid
                ? Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: SizedBox(
                      width: _bannerAd!.size.width.toDouble(),
                      height: _bannerAd!.size.height.toDouble(),
                      child: AdWidget(ad: _bannerAd!),
                    ),
                  )
                : SizedBox(
                    width: _bannerAd!.size.width.toDouble(),
                    height: _bannerAd!.size.height.toDouble(),
                    child: AdWidget(ad: _bannerAd!),
                  ),
          );
  }

  // Widget currentAd = SizedBox(
  //   width: 0.0,
  //   height: 0.0,
  // );
   loadInterstitialAd() {
    FacebookInterstitialAd.loadInterstitialAd(
      // placementId: "YOUR_PLACEMENT_ID",
      placementId: "IMG_16_9_APP_INSTALL#2312433698835503_2650502525028617",
      listener: (result, value) {
        print(">> FAN > Interstitial Ad: $result --> $value");
        if (result == InterstitialAdResult.LOADED)
         {
          FacebookInterstitialAd.showInterstitialAd(delay:5000);
        }
      },
    );
  }
 _showBannerAd() {
    setState(() {
     FacebookBannerAd(
        // placementId: "YOUR_PLACEMENT_ID",
        placementId:
            "IMG_16_9_APP_INSTALL#2312433698835503_2964944860251047", //testid
        bannerSize: BannerSize.STANDARD,
        listener: (result, value) {
          print("Banner Ad: $result -->  $value");
        },
      );
    });
  }
  //endregion

  final List<ItemModelTuViHangNgay> _items = itemListTuViHangNgay;
  final DateTime _calendar = DateTime.now();

  void _onItemFocus(int index) {
    //print(index);
    setState(() {
      _focusedIndex = index;
    });
  }

  Widget _buildItemDetail(dynamic dayOfWeek, dynamic screenHeight) {
    if (_items.length > _focusedIndex) {
      return Column(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Container(
                    height: (screenHeight * 13 / 100),
                    width: 340,
                    decoration: BoxDecoration(
                      color: const Color(0xffF27E3C),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Image(
                                height: 48,
                                width: 48,
                                image: AssetImage('assets/icons/tuvi1.png')),
                            Text(
                              _items[_focusedIndex].ten.tr(),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700),
                            ),
                            const Image(
                                height: 48,
                                width: 48,
                                image: AssetImage('assets/icons/tuvi1.png')),
                          ],
                        ),
                        ValueListenableBuilder(
                          valueListenable: fontSizeNotifier,
                          builder: (context, fontSize, _) {
                            return Text(
                              '$dayOfWeek ${_calendar.day}-${_calendar.month}-${_calendar.year}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Container(
                  height: (screenHeight * 45 / 100),
                  width: 340,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 20, bottom: 5, right: 10, left: 10),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                           Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'explain'.tr(),
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.red,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          ValueListenableBuilder(
                            valueListenable: fontSizeNotifier,
                            builder: (context, fontSize, _) {
                              return Text(
                                _items[_focusedIndex].noidung.tr(),
                                style: TextStyle(
                                    fontSize: fontSize,
                                    fontWeight: FontWeight.w400),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    return const Text("No Data");
  }

  Widget _buildListItem(BuildContext context, int index) {
    if (index == _items.length) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    //horizontal
    return SizedBox(
      width: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            height: 100,
            width: 100,
            image: AssetImage(_items[index].image),
          )
        ],
      ),
    );
  }
  // double customEquation(double distance) {
  //   // return 1-min(distance.abs()/500, 0.2);
  //   return 1 - (distance / 1000);
  // }

  @override
  Widget build(BuildContext context) {
    var dayOfWeek = getNameDayOfWeek(_calendar);
    final Size screenSize = MediaQuery.of(context).size;

    final double screenHeight = screenSize.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffFBBA95),
        automaticallyImplyLeading: false,
        title: const Text(
          'daily_horoscope',
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
      body: Stack(
        children: [
          Container(
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
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Center(
                    child: ScrollSnapList(
                      onItemFocus: _onItemFocus,
                      itemSize: 150,
                      itemBuilder: _buildListItem,
                      itemCount: _items.length,
                      dynamicItemSize: true,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                    flex: 8, child: _buildItemDetail(dayOfWeek, screenHeight)),
              ],
            ),
          ),
          Positioned(
            right: 10,
            bottom: 60,
            child: Column(
              children: [
                TextButton(
                  onPressed: increaseFontSize,
                  child: const Icon(
                    Icons.add_circle,
                    color: Colors.red,
                  ),
                ),
                TextButton(
                  onPressed: decreaseFontSize,
                  child: const Icon(
                    Icons.remove_circle,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
          Positioned(left: 0, bottom: 0, right: 0, child: Container(
  alignment: Alignment(0.5, 1),
  child: FacebookBannerAd(
    placementId: Platform.isAndroid ? "IMG_16_9_APP_INSTALL#2312433698835503_2650502525028617" : "IMG_16_9_APP_INSTALL#2312433698835503_2650502525028617",
    bannerSize: BannerSize.STANDARD,
    listener: (result, value) {
      switch (result) {
        case BannerAdResult.ERROR:
          print("Error: $value");
          break;
        case BannerAdResult.LOADED:
          print("Loaded: $value");
          break;
        case BannerAdResult.CLICKED:
          print("Clicked: $value");
          break;
        case BannerAdResult.LOGGING_IMPRESSION:
          print("Logging Impression: $value");
          break;
      }
    },
  ),
))
        ],
      ),
    );
  }
}
