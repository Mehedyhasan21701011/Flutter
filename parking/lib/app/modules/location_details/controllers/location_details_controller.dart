import 'package:get/get.dart';

class LocationDetailsController extends GetxController {
  //TODO: Implement LocationDetailsController
    final args = Get.arguments as Map<String, String>; // args is a Map


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
