import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:parking/app/routes/app_pages.dart';

class LoginController extends GetxController {
  // Observables
  var isLoginMode = true.obs;
  var isLoading = false.obs;
  var isPasswordVisible = false.obs;
  var isConfirmPasswordVisible = false.obs;

  // Form Controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();

  // Focus Nodes
  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();
  final confirmPasswordFocus = FocusNode();
  final nameFocus = FocusNode();

  // Form Key
  final formKey = GlobalKey<FormState>();

  // Firebase Auth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Toggle login/signup
  void toggleAuthMode() {
    isLoginMode.value = !isLoginMode.value;
    clearForm();
  }

  void togglePasswordVisibility() =>
      isPasswordVisible.value = !isPasswordVisible.value;

  void toggleConfirmPasswordVisibility() =>
      isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;

  void clearForm() {
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    nameController.clear();
    formKey.currentState?.reset();
    emailFocus.unfocus();
    passwordFocus.unfocus();
    confirmPasswordFocus.unfocus();
    nameFocus.unfocus();
  }

  // Validators
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your email';
    if (!GetUtils.isEmail(value)) return 'Please enter a valid email';
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your password';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (!isLoginMode.value) {
      if (value == null || value.isEmpty) return 'Please confirm your password';
      if (value != passwordController.text) return 'Passwords do not match';
    }
    return null;
  }

  String? validateName(String? value) {
    if (!isLoginMode.value) {
      if (value == null || value.isEmpty) return 'Please enter your name';
      if (value.length < 2) return 'Name must be at least 2 characters';
    }
    return null;
  }

  // Submit form
  Future<void> submitForm() async {
    if (!formKey.currentState!.validate()) return;
    isLoading.value = true;

    try {
      UserCredential userCredential;
      if (isLoginMode.value) {
        userCredential = await _auth.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        Get.snackbar(
          "Login Successful",
          "Welcome back, ${userCredential.user?.email}",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.offAllNamed(Routes.HOME);
      } else {
        userCredential = await _auth.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        await userCredential.user?.updateDisplayName(nameController.text);
        Get.snackbar(
          "Account Created",
          "Welcome, ${nameController.text}!",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
      clearForm();
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        "Error",
        e.message ?? "Authentication failed",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nameController.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    confirmPasswordFocus.dispose();
    nameFocus.dispose();
    super.onClose();
  }
}
