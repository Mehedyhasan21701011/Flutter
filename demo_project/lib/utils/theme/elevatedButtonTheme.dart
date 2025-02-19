import 'package:flutter/material.dart';

class TElevatedbuttontheme {
  TElevatedbuttontheme._();
  static ElevatedButtonThemeData lightButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        elevation: 0,
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        disabledForegroundColor: Colors.grey,
        disabledBackgroundColor: Colors.grey,
        side: BorderSide(color: Colors.blue),
        padding: EdgeInsets.symmetric(vertical: 18),
        textStyle: TextStyle(
            fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
  );
  static ElevatedButtonThemeData darkButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        elevation: 0,
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        disabledForegroundColor: Colors.grey,
        disabledBackgroundColor: Colors.grey,
        side: BorderSide(color: Colors.blue),
        padding: EdgeInsets.symmetric(vertical: 18),
        textStyle: TextStyle(
            fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
  );
}
