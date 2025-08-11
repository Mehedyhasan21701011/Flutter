import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/logout_controller.dart';

class LogoutView extends GetView<LogoutController> {
  const LogoutView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('LogoutView'), centerTitle: true),
      body: Center(
        child: Column(
          children: [
            Text(controller.controlLogOut.currentUser?.email ?? "No user"),
            ElevatedButton(
              onPressed: () {
                controller.controlLogOut.logOut();
              },
              child: const Text("Log Out "),
            ),
          ],
        ),
      ),
    );
  }
}
