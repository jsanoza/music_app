import 'package:get/get.dart';

import '../../../app/data/provider/player_provider.dart';
import '../../../app/modules/player_module/player_controller.dart';

class PlayerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PlayerController>(
      () => PlayerController(
        provider: PlayerProvider(),
      ),
    );
  }
}
