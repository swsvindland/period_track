import "package:os_detect/os_detect.dart" as platform;
import 'dart:io';
import 'package:flutter/foundation.dart';

class AdHelper {

  static String get bannerAdUnitId {
    if (kDebugMode) {
      if (Platform.isAndroid) {
        return 'ca-app-pub-3940256099942544/6300978111';
      } else if (Platform.isIOS) {
        return 'ca-app-pub-3940256099942544/2934735716';
      } else {
        throw UnsupportedError('Unsupported platform');
      }
    }

    if (Platform.isAndroid) {
      return 'ca-app-pub-7533750599105635/7832792717';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-7533750599105635/2594028033';
    } else {
      throw UnsupportedError('Unsupported platform');
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