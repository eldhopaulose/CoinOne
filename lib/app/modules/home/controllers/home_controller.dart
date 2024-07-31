import 'package:coin_one/app/data/dio/repo/home_repo.dart';
import 'package:coin_one/app/data/models/home_res_model.dart';
import 'package:coin_one/app/modules/login/views/login_view.dart';
import 'package:coin_one/app/services/admob_seervices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  int _interstitialLoadAttempts = 0;
  int maxFailedLoadAttempts = 3;

  // Initialize Firebase Auth
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    _initializeAds();
    showInterstitialAd();
  }

  @override
  void onReady() {
    super.onReady();
  }

  // Ad Related
  final Rx<BannerAd?> _banner = Rx<BannerAd?>(null);
  final Rx<InterstitialAd?> _interstitial = Rx<InterstitialAd?>(null);
  final Rx<RewardedAd?> _reward = Rx<RewardedAd?>(null);
  final RxBool _showReward = false.obs;

  BannerAd? get bannerAd => _banner.value;
  InterstitialAd? get interstitialAd => _interstitial.value;
  RewardedAd? get rewardAd => _reward.value;
  bool get showReward => _showReward.value;

  late final AdMobServices _adMobService;

  @override
  void onClose() {
    _banner.value?.dispose();
    _interstitial.value?.dispose();
    _reward.value?.dispose();
    super.onClose();
  }

  Future<List<HomeRes>> getHome() async {
    final HomeRepo _homeRepo = HomeRepo();
    try {
      return await _homeRepo.getHome();
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch home data: $e');
      return [];
    }
  }

  void _initializeAds() {
    _adMobService = Get.find<AdMobServices>();
    _adMobService.initialization.then((value) {
      _createBannerAd();
      _createInterstitialAd();
      _createRewardAd();
    });
  }

  void _createBannerAd() {
    _banner.value = BannerAd(
      adUnitId: _adMobService.bannerAdUnitId!,
      size: AdSize.fullBanner,
      request: AdRequest(),
      listener: _adMobService.bannerAdListener,
    )..load();
  }

  void _createInterstitialAd() {
    InterstitialAd.load(
      adUnitId: _adMobService.interstitialAdUnitId!,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitial.value = ad;
          _interstitialLoadAttempts = 0;
        },
        onAdFailedToLoad: (error) {
          _interstitialLoadAttempts++;
          _interstitial.value = null;
          if (_interstitialLoadAttempts <= maxFailedLoadAttempts) {
            _createInterstitialAd();
          }
        },
      ),
    );
  }

  void showInterstitialAd() {
    if (_interstitial.value == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    _interstitial.value!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createInterstitialAd();
      },
    );
    _interstitial.value!.show();
    _interstitial.value = null;
  }

  void _createRewardAd() {
    RewardedAd.load(
      adUnitId: _adMobService.rewardedAdUnitId!,
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) => _reward.value = ad,
        onAdFailedToLoad: (error) => print('RewardedAd failed to load: $error'),
      ),
    );
  }

  void logout() async {
    try {
      await auth.signOut();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('keepLoggedIn', false);
      Get.offAll(() => LoginView());
    } catch (e) {
      Get.snackbar("Error", e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }
}
