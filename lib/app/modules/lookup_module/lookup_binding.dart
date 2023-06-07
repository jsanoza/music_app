import 'package:get/get.dart';

import '../../../app/data/provider/lookup_provider.dart';
import '../../../app/modules/lookup_module/lookup_controller.dart';

class LookupBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LookupController>(
      () => LookupController(
        provider: LookupProvider(),
      ),
    );
  }
}
