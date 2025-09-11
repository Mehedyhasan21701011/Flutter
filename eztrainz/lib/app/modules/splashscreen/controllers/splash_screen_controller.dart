import 'package:eztrainz/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'dart:async';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Timer(const Duration(seconds: 3), () {
      Get.offNamed(Routes.ONBOARDINGSCREEN); 
    });
  }
}
