import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:practic_module/app/routes/app_pages.dart';

class LoginController extends GetxController {
  var isLogin = true.obs;
  late FirebaseAuth _auth;

  void toggle() => isLogin.value = !isLogin.value;
  @override
  void onInit() {
    super.onInit();
    _auth = FirebaseAuth.instance; // ✅ initialize here
  }

  Future<void> login(String email, String pass) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: pass);
      Get.offAllNamed(Routes.HOME);
      Get.snackbar("Login Success", "Welcome back!");
    } catch (e) {
      Get.snackbar("Login Failed", e.toString());
    }
  }

  Future<void> signUp(String email, String pass) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: pass);
      Get.snackbar("Success", "Account created successfully");
    } catch (e) {
      Get.snackbar("Sign Up Failed", e.toString());
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    Get.offAllNamed(Routes.LOGIN);
    Get.snackbar("Logged Out", "You have been logged out");
  }
}
