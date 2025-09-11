import 'package:get/get.dart';

import '../controllers/locationpage_controller.dart';

class LocationpageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocationController>(
      () => LocationController(),
    );
  }
}
