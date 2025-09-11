import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/onboardingscreen_controller.dart';

class OnboardingscreenView extends GetView<OnboardingscreenController> {
  const OnboardingscreenView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OnboardingscreenView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'OnboardingscreenView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
