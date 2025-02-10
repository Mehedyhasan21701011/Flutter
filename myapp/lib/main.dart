import 'package:flutter/material.dart';
import 'package:myapp/Module/homePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homepage(), // Corrected class name to PascalCase
    );
  }
}
