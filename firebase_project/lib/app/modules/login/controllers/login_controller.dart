import 'package:firebase_project/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? get currentUser => auth.currentUser;
  final box = GetStorage();

  void createUser(String email, String password) async {
    try {
      if (email.isEmpty || password.isEmpty) {
        Get.snackbar("Error", "email and pass is required");
        return;
      }
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      Get.snackbar("Success", "User is created");
      Get.offAllNamed(Routes.LOGIN);
    } catch (e) {
      print(e);
    }
  }

  void login(String email, String password) async {
    try {
      if (email.isEmpty || password.isEmpty) {
        Get.snackbar("Error", "Email and pass is wrong");
        return;
      }
      String token = '1234';
      await auth.signInWithEmailAndPassword(email: email, password: password);
      Get.snackbar("Success", "Logged in as $email");
      await box.write('token', token);
      // Navigate to dashboard after successful login
      Get.offAllNamed('/home');
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  void logOut() async {
    await auth.signOut();
    await box.remove('token');
    Get.toNamed(Routes.LOGIN);
  }
}
