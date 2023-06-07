import 'package:get/get.dart';
import 'package:music_app/app/data/provider/home_provider.dart';
import 'package:music_app/app/modules/home_module/home_controller.dart';

import '../../data/provider/player_provider.dart';
import '../player_module/player_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(
        provider: HomeProvider(),
      ),
    );
  }
}
