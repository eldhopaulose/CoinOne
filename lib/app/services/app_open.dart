import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:get/get.dart';
import 'package:coin_one/app/services/admob_seervices.dart';

class AppOpenAdController extends GetxController {
  AppOpenAd? _appOpenAd;
  var isAdAvailable = false.obs;
  var isShowingAd = false.obs;

  final AdMobServices _adMobServices = Get.find<AdMobServices>();

  @override
  void onInit() {
    super.onInit();
    _initializeAds();
  }

  /// Initialize and load AppOpenAd.
  void _initializeAds() {
    if (_adMobServices.appOpenAdUnitId != null) {
      loadAd();
    } else {
      print('App Open Ad Unit ID is not set.');
    }
  }

  /// Load an AppOpenAd.
  void loadAd() {
    AppOpenAd.load(
      adUnitId: _adMobServices.appOpenAdUnitId!,
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          print('AppOpenAd loaded');
          _appOpenAd = ad;
          isAdAvailable.value = true;
          if (!isShowingAd.value) {
            showAdIfAvailable();
          }
        },
        onAdFailedToLoad: (error) {
          print('AppOpenAd failed to load: $error');
          isAdAvailable.value = false;
        },
      ),
    );
  }

  /// Show the ad if available.
  void showAdIfAvailable() {
    if (!isAdAvailable.value) {
      print('AppOpenAd is not available.');
      return;
    }
    if (isShowingAd.value) {
      print('AppOpenAd is already showing.');
      return;
    }

    _appOpenAd?.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {
        print('AppOpenAd showed full screen content.');
        isShowingAd.value = true;
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        print('AppOpenAd failed to show full screen content: $error');
        isShowingAd.value = false;
        ad.dispose();
        _appOpenAd = null;
        isAdAvailable.value = false; // Update availability status
        loadAd(); // Load a new ad for the next time
      },
      onAdDismissedFullScreenContent: (ad) {
        print('AppOpenAd dismissed full screen content.');
        isShowingAd.value = false;
        ad.dispose();
        _appOpenAd = null;
        isAdAvailable.value = false; // Update availability status
        // Load a new ad only if required
        // loadAd(); // Uncomment if you want to preload another ad
      },
    );

    _appOpenAd?.show().then((_) {
      // Ad has been shown, set the flag to false
      isShowingAd.value = false;
      // Optional: You can choose to preload a new ad if needed
      // loadAd(); // Uncomment if you want to preload another ad
    }).catchError((error) {
      print('Failed to show AppOpenAd: $error');
      isShowingAd.value = false;
      _appOpenAd?.dispose();
      _appOpenAd = null;
      isAdAvailable.value = false;
      // Optionally, reload the ad or handle error
      // loadAd(); // Uncomment if you want to reload an ad
    });
  }
}
