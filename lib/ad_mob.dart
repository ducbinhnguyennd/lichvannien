import 'dart:io';

class AdMob {
  static String? get bannerAdMob {
    if (Platform.isAndroid) {
      return 'ca-app-pub-4581609566332172/7955840352';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-4581609566332172/9452894475';
    }
    return null;
  }
}
