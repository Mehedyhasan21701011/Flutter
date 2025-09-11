import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    final size = MediaQuery.of(context).size;
    final isPortrait = size.height > size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF0F8FF),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 🚗 Parking App Logo
                Icon(
                  Icons.local_parking,
                  size: isPortrait ? 100 : 70,
                  color: Colors.blueAccent,
                ),
                const SizedBox(height: 12),

                Obx(
                  () => Text(
                    controller.isLoginMode.value
                        ? "Welcome Back"
                        : "Create Account",
                    style: TextStyle(
                      fontSize: isPortrait ? 28 : 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  "Park smarter with our app 🚗",
                  style: TextStyle(
                    fontSize: isPortrait ? 16 : 14,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 30),

                // Name (only for Sign Up)
                Obx(
                  () => !controller.isLoginMode.value
                      ? TextFormField(
                          controller: controller.nameController,
                          focusNode: controller.nameFocus,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.person),
                            labelText: "Name",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: controller.validateName,
                        )
                      : const SizedBox.shrink(),
                ),

                const SizedBox(height: 12),

                // Email
                TextFormField(
                  controller: controller.emailController,
                  focusNode: controller.emailFocus,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email),
                    labelText: "Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: controller.validateEmail,
                ),

                const SizedBox(height: 12),

                // Password
                Obx(
                  () => TextFormField(
                    controller: controller.passwordController,
                    focusNode: controller.passwordFocus,
                    obscureText: !controller.isPasswordVisible.value,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      labelText: "Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.isPasswordVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: controller.togglePasswordVisibility,
                      ),
                    ),
                    validator: controller.validatePassword,
                  ),
                ),

                const SizedBox(height: 12),

                // Confirm Password (only for Sign Up)
                Obx(
                  () => !controller.isLoginMode.value
                      ? TextFormField(
                          controller: controller.confirmPasswordController,
                          focusNode: controller.confirmPasswordFocus,
                          obscureText:
                              !controller.isConfirmPasswordVisible.value,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock_outline),
                            labelText: "Confirm Password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                controller.isConfirmPasswordVisible.value
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed:
                                  controller.toggleConfirmPasswordVisibility,
                            ),
                          ),
                          validator: controller.validateConfirmPassword,
                        )
                      : const SizedBox.shrink(),
                ),

                const SizedBox(height: 25),

                // Submit Button
                Obx(
                  () => controller.isLoading.value
                      ? const CircularProgressIndicator()
                      : SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: controller.submitForm,
                            child: Text(
                              controller.isLoginMode.value
                                  ? "Login"
                                  : "Sign Up",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                ),

                const SizedBox(height: 16),

                // Toggle Button
                TextButton(
                  onPressed: controller.toggleAuthMode,
                  child: Obx(
                    () => Text(
                      controller.isLoginMode.value
                          ? "Don’t have an account? Sign Up"
                          : "Already have an account? Login",
                      style: const TextStyle(color: Colors.blueAccent),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
