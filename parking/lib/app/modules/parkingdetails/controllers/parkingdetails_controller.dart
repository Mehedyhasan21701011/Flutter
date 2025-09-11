import 'package:get/get.dart';

class ParkingdetailsController extends GetxController {

  final args = Get.arguments as Map<String, dynamic>;
  
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
