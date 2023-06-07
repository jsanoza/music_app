import 'dart:developer';

import 'package:get/get.dart';
import 'package:music_app/app/modules/home_module/home_controller.dart';
import 'package:music_app/app/modules/home_module/sample.dart';
import '../../../app/data/provider/splash_provider.dart';
import '../../data/model/rank_albums_model.dart';
import '../../data/model/rank_artists_model.dart';
import '../../data/model/rank_tracks_model.dart';
import '../../routes/app_pages.dart';
import '../home_module/trial.dart';

class SplashController extends GetxController {
  final SplashProvider? provider;
  SplashController({this.provider});

  @override
  void onInit() {
    splashDone();
    super.onInit();
  }

  splashDone() {
    Future.delayed(const Duration(seconds: 2), () {
      Get.offNamed(AppRoutes.home);
    });
  }
}
