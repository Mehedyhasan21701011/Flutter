import 'package:get/get.dart';

import '../controllers/activitypage_controller.dart';

class ActivitypageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ActivityPageController>(() => ActivityPageController());
  }
}
