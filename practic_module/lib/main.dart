import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAuth.instance.signOut();
  // FIXED: Added parentheses
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Firebase Auth Demo",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
