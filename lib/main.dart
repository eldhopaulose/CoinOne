import 'package:coin_one/app/services/admob_controller.dart';
import 'package:coin_one/app/services/admob_seervices.dart';
import 'package:coin_one/app/services/app_open.dart';
import 'package:coin_one/constants.dart';
import 'package:coin_one/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final adMobServices = AdMobServices(MobileAds.instance.initialize());

  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: kScaffoldBackgroundColor,
        useMaterial3: true,
      ),
      initialBinding: BindingsBuilder(() {
        Get.put(AdmobController(adMobServices: adMobServices));
        Get.put(adMobServices);
        Get.put(AppOpenAdController());
      }),
    ),
  );
}
