import 'package:get/get.dart';

import '../controllers/part_controller.dart';

class PartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PartController>(
      () => PartController(),
    );
  }
}
