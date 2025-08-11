import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:get/get.dart';

import 'package:practic_module/app/modules/login/controllers/login_controller.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final logController = Get.put(LoginController());
    User? usr = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: CircleAvatar(
              backgroundImage:
                  usr?.photoURL != null ? NetworkImage(usr!.photoURL!) : null,
              child: usr?.photoURL == null ? const Icon(Icons.person) : null,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (usr != null) Text("Hello ${usr.email ?? 'User'}"),

            const SizedBox(height: 20),

            ElevatedButton.icon(
              icon: const Icon(Icons.image),
              label: const Text("Upload Profile Picture"),
              onPressed: () async {
                final picker = ImagePicker();

                try {
                  final pickedFile = await picker.pickImage(
                    source: ImageSource.gallery,
                  );

                  if (pickedFile == null) {
                    print('No image selected');
                    return;
                  }

                  final file = File(pickedFile.path);
                  final fileExists = await file.exists();
                  print('File exists: $fileExists'); // Should be true

                  if (!fileExists) {
                    Get.snackbar("Error", "Selected file does not exist.");
                    return;
                  }

                  if (usr == null) {
                    Get.snackbar("Error", "User not logged in.");
                    return;
                  }

                  final fileName = basename(pickedFile.path);
                  final storagePath = "profile_images/${usr.uid}_$fileName";
                  print('Uploading file to: $storagePath');

                  final ref = FirebaseStorage.instance.ref().child(storagePath);

                  // Show loading dialog
                  Get.dialog(
                    const Center(child: CircularProgressIndicator()),
                    barrierDismissible: false,
                  );

                  // Upload file
                  await ref.putFile(file);
                  print('Upload complete');

                  // Get download URL
                  final downloadURL = await ref.getDownloadURL();
                  print('Download URL: $downloadURL');

                  // Update user profile photo URL
                  await usr.updatePhotoURL(downloadURL);
                  await usr.reload();

                  Get.back(); // Close loading dialog

                  Get.snackbar("Success", "Profile photo updated!");

                  // Refresh view to update avatar
                  Get.offAll(() => const HomeView());
                } catch (e) {
                  Get.back(); // Close loading dialog if open
                  print('Upload error: $e');
                  Get.snackbar("Error", e.toString());
                }
              },
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                logController.logout();
              },
              child: const Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}
