import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobServices {
  final Future<InitializationStatus> initialization;

  AdMobServices(this.initialization);

  Future<void> initialize() async {
    await initialization;
  }

  String? get bannerAdUnitId {
    if (kReleaseMode) {
      if (Platform.isIOS) {
        return 'ca-app-pub-3940256099942544/2435281174';
      } else if (Platform.isAndroid) {
        return 'ca-app-pub-3940256099942544/9214589741';
      }
    } else {
      if (Platform.isIOS) {
        return 'ca-app-pub-3940256099942544/2435281174';
      } else if (Platform.isAndroid) {
        return 'ca-app-pub-3940256099942544/9214589741';
      }
    }
    return null;
  }

  String? get interstitialAdUnitId {
    if (kReleaseMode) {
      if (Platform.isIOS) {
        return "ca-app-pub-3940256099942544/1033173712";
      } else if (Platform.isAndroid) {
        return "ca-app-pub-3940256099942544/1033173712";
      }
    } else {
      if (Platform.isIOS) {
        return "ca-app-pub-3940256099942544/1033173712";
      } else if (Platform.isAndroid) {
        return "ca-app-pub-3940256099942544/1033173712";
      }
    }
    return null;
  }

  String? get rewardedAdUnitId {
    if (kReleaseMode) {
      if (Platform.isIOS) {
        return 'ca-app-pub-3940256099942544/5224354917';
      } else if (Platform.isAndroid) {
        return 'ca-app-pub-3940256099942544/5224354917';
      }
    } else {
      if (Platform.isIOS) {
        return 'ca-app-pub-3940256099942544/5224354917';
      } else if (Platform.isAndroid) {
        return 'ca-app-pub-3940256099942544/5224354917';
      }
    }
    return null;
  }

  String? get appOpenAdUnitId {
    if (kReleaseMode) {
      if (Platform.isIOS) {
        return 'ca-app-pub-3940256099942544/9257395921';
      } else if (Platform.isAndroid) {
        return 'ca-app-pub-3940256099942544/9257395921';
      }
    } else {
      if (Platform.isIOS) {
        return 'ca-app-pub-3940256099942544/9257395921';
      } else if (Platform.isAndroid) {
        return 'ca-app-pub-3940256099942544/9257395921';
      }
    }
    return null;
  }

  // Add native ad unit ID
  String? get nativeAdUnitId {
    if (kReleaseMode) {
      if (Platform.isIOS) {
        return 'ca-app-pub-3940256099942544/2247696110'; // Replace with your actual iOS native ad unit ID
      } else if (Platform.isAndroid) {
        return 'ca-app-pub-3940256099942544/2247696110'; // Replace with your actual Android native ad unit ID
      }
    } else {
      if (Platform.isIOS) {
        return 'ca-app-pub-3940256099942544/2247696110'; // Replace with your actual iOS native ad unit ID
      } else if (Platform.isAndroid) {
        return 'ca-app-pub-3940256099942544/2247696110'; // Replace with your actual Android native ad unit ID
      }
    }
    return null;
  }

  final BannerAdListener bannerAdListener = BannerAdListener(
    onAdLoaded: (Ad ad) => print("Ad Loaded"),
    onAdFailedToLoad: (Ad ad, LoadAdError error) {
      ad.dispose();
      print('Ad Failed to Load: $error');
    },
    onAdOpened: (Ad ad) => print("Ad Opened"),
    onAdClosed: (Ad ad) => print("Ad Closed"),
  );
}
