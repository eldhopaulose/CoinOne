import 'package:coin_one/app/services/admob_seervices.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdmobController extends GetxController {
  final AdMobServices adMobServices;

  AdmobController({required this.adMobServices});

  @override
  void onInit() {
    super.onInit();
    _initializeAdMob();
  }

  Future<void> _initializeAdMob() async {
    await MobileAds.instance.initialize();
    await adMobServices.initialize();
  }
}
