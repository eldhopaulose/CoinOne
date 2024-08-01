import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class NativeAdController extends GetxController {
  NativeAd? nativeAd;
  var isNativeAdLoaded = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadNativeAd();
  }

  void loadNativeAd() {
    nativeAd = NativeAd(
      adUnitId: 'ca-app-pub-3940256099942544/2247696110', // Test ad unit ID
      factoryId: 'nativeAdFactory',
      request: AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          print('Native ad loaded');
          isNativeAdLoaded.value = true;
        },
        onAdFailedToLoad: (ad, error) {
          print('Native ad failed to load: $error');
          ad.dispose();
        },
      ),
    );
    nativeAd!.load();
  }

  @override
  void onClose() {
    nativeAd?.dispose();
    super.onClose();
  }
}
