import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../utils/ad_helper.dart';

class NoteAd extends StatefulWidget {
  const NoteAd({Key? key}) : super(key: key);

  @override
  State<NoteAd> createState() => _NoteAdState();
}

class _NoteAdState extends State<NoteAd> {
  late BannerAd? _bannerAd;
  bool _isBannerAdReady = false;

  @override
  void initState() {
    super.initState();

    _bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: const AdRequest(nonPersonalizedAds: true),
      size: const AdSize(width: 300, height: 50),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          _isBannerAdReady = false;
          ad.dispose();
        },
      ),
    );

    _bannerAd?.load();
  }

  @override
  void dispose() {
    super.dispose();

    _bannerAd?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_bannerAd == null || !_isBannerAdReady) {
      return const Card(
        child: ListTile(
          title: Text("Loading Ad..."),
        ),
      );
    }

    return Card(
      child: SizedBox(
        width: 300,
        height: 50,
        child: AdWidget(ad: _bannerAd!),
      ),
    );
  }
}
