import 'package:get/get.dart';
class MainController extends GetxController {
  var currentIndex = 0.obs;
  var isLoading = false.obs;
  var userLocation = 'Loading...'.obs;

  void changeTabIndex(int index) {
    currentIndex.value = index;
  }

  void simulateLocationLoading() async {
    isLoading.value = true;
    await Future.delayed(Duration(seconds: 2));
    userLocation.value = 'Chattogram, Bangladesh';
    isLoading.value = false;
  }

  @override
  void onInit() {
    super.onInit();
    simulateLocationLoading();
  }
}


