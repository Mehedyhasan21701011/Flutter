import 'package:get/get.dart';

import '../controllers/parkingdetails_controller.dart';

class ParkingdetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ParkingdetailsController>(
      () => ParkingdetailsController(),
    );
  }
}
