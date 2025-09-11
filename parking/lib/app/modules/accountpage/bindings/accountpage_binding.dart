import 'package:get/get.dart';

import '../controllers/accountpage_controller.dart';

class AccountpageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AccountPageController>(() => AccountPageController());
  }
}
