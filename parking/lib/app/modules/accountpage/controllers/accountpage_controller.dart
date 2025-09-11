import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:html' as html;
import 'package:parking/app/routes/app_pages.dart';

class AccountPageController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final RxString photoUrl = ''.obs;
  final RxBool isUploading = false.obs;

  var userName = ''.obs;
  var userEmail = ''.obs;
  var totalSavings = '৳0'.obs;
  var totalParkings = '0'.obs;

  @override
  void onInit() {
    super.onInit();
    _loadUserData();
  }

  void _loadUserData() {
    final user = _auth.currentUser;
    if (user != null) {
      userName.value = user.displayName ?? "Unknown User";
      userEmail.value = user.email ?? "No Email";
      photoUrl.value = user.photoURL ?? '';
    } else {
      userName.value = "Guest";
      userEmail.value = "guest@example.com";
    }
  }

  Future<void> pickAndUploadImage({bool fromCamera = false}) async {
    try {
      isUploading.value = true;
      String uid = _auth.currentUser!.uid;
      Uint8List? webData;
      File? mobileFile;

      // ===== WEB =====
      if (kIsWeb) {
        final html.FileUploadInputElement uploadInput =
            html.FileUploadInputElement();
        uploadInput.accept = 'image/*';
        uploadInput.click();

        await uploadInput.onChange.first;

        final html.File file = uploadInput.files!.first;
        final reader = html.FileReader();
        reader.readAsArrayBuffer(file);
        await reader.onLoad.first;
        webData = reader.result as Uint8List;
      } else {
        final picker = ImagePicker();
        // ===== MOBILE =====
        if (Platform.isAndroid || Platform.isIOS) {
          final XFile? pickedFile = await picker.pickImage(
            source: fromCamera ? ImageSource.camera : ImageSource.gallery,
            imageQuality: 80,
          );
          if (pickedFile != null) mobileFile = File(pickedFile.path);
        } else {
          // ===== DESKTOP =====
          FilePickerResult? result = await FilePicker.platform.pickFiles(
            type: FileType.image,
          );
          if (result != null && result.files.single.path != null) {
            mobileFile = File(result.files.single.path!);
          }
        }
      }

      // ===== Upload =====
      Reference ref = FirebaseStorage.instance.ref().child(
        'profile_images/$uid.jpg',
      );

      if (kIsWeb && webData != null) {
        await ref.putData(webData);
      } else if (mobileFile != null) {
        await ref.putFile(mobileFile);
      } else {
        throw 'No image selected';
      }

      String downloadURL = await ref.getDownloadURL();
      await _auth.currentUser!.updatePhotoURL(downloadURL);
      photoUrl.value = downloadURL;

      Get.snackbar(
        'Success',
        'Profile image updated successfully',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isUploading.value = false;
    }
  }

  Future<void> logOut() async {
    await _auth.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }
}
