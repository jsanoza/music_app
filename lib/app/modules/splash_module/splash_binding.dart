import 'package:get/get.dart';
import 'package:music_app/app/data/provider/home_provider.dart';
import 'package:music_app/app/modules/home_module/home_controller.dart';

import '../../../app/data/provider/splash_provider.dart';
import '../../../app/modules/splash_module/splash_controller.dart';

class SplashBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(
      () => SplashController(
        provider: SplashProvider(),
      ),
    );
  }
}
