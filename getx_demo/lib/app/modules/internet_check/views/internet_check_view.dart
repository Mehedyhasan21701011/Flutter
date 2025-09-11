import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/internet_check_controller.dart';

class InternetCheckView extends GetView<InternetCheckController> {
  const InternetCheckView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('InternetCheckView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'InternetCheckView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
