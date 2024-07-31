import 'package:coin_one/app/services/app_open.dart';
import 'package:coin_one/constants.dart';
import 'package:coin_one/app/modules/widgets/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shimmer/shimmer.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kScaffoldBackgroundColor,
        title: const Text(
          'Home',
          style: TextStyle(
            color: kPrimaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: kPrimaryColor,
            ),
            onPressed: () {
              controller.logout();
            },
          )
        ],
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: FutureBuilder(
              future: controller.getHome(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CardWidget(
                            Name: 'Name',
                            Img:
                                'https://coinoneglobal.in/crm/UploadFiles/Template/coinone.png',
                          ),
                        );
                      },
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.data!.isEmpty) {
                  return const Center(child: Text('No data found'));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            Get.toNamed('/info',
                                arguments: snapshot.data![index].id.toString());
                            controller.showInterstitialAd();
                          },
                          child: CardWidget(
                            Name: snapshot.data![index].name.toString(),
                            Img:
                                'https://coinoneglobal.in/crm/UploadFiles/Template/${snapshot.data![index].imgUrl.toString()}',
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          Obx(() => controller.bannerAd != null
              ? Container(
                  height: 60,
                  child: AdWidget(ad: controller.bannerAd!),
                )
              : SizedBox(height: 10)),
        ],
      ),
    );
  }
}
