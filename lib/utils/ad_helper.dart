import 'dart:io';
import "package:os_detect/os_detect.dart" as platform;

class AdHelper {

  static String get bannerAdUnitId {
    if (platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/6300978111';
    } else if (platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716';
    } else {
      return '';
    }
  }

  static String get interstitialAdUnitId {
    if (platform.isAndroid) {
      return "ca-app-pub-3940256099942544/1033173712";
    } else if (platform.isIOS) {
      return "ca-app-pub-3940256099942544/4411468910";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get rewardedAdUnitId {
    if (platform.isAndroid) {
      return "ca-app-pub-3940256099942544/5224354917";
    } else if (platform.isIOS) {
      return "ca-app-pub-3940256099942544/1712485313";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }
}