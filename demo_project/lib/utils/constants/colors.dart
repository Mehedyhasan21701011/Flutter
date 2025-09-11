import 'package:flutter/material.dart';

class TColors {
  TColors._();

  //gradient colors
  static const LinearGradient gradientPrimary = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment(0.707, -0.707),
    colors: [
      Color.fromARGB(255, 226, 149, 128),
      Color.fromARGB(255, 225, 183, 168),
      Color.fromARGB(255, 243, 203, 200)
    ],
  );

  //app basic color
  static const Color primary = Colors.blue;
  static const Color secondary = Colors.yellow;
  static const Color accent = Color(0xFFb0c7ff);
//text color
  static const Color textPrimary = Colors.black;
  static const Color textSecondary = Color.fromARGB(255, 108, 107, 104);
  static const Color textWhite = Colors.white;

//background
  static const Color light = Color(0xfff6f6f6f);
  static const Color dark = Color(0xFF272727);
  static const Color primaryBackground = Color(0xFFF3F5FF);

//button
  static const Color ButtonPrimary = Colors.blue;
  static const Color ButtonSecondary = Colors.grey;
  static const Color ButtonDisabled = Colors.white;
//border
  static const Color borderPrimary = Color.fromARGB(255, 90, 87, 87);
  static const Color borderSecondary = Color.fromARGB(255, 180, 174, 174);

  //background container color
  static const Color lightContainer = Color.fromARGB(255, 248, 245, 245);
  static const Color darkContainer = Colors.black;

  //error and validatioin color
  static const Color error = Colors.red;
  static const Color success = Color.fromARGB(255, 3, 152, 15);
  static const Color warning = Color.fromARGB(255, 249, 123, 38);
  static const Color info = Color.fromARGB(255, 54, 105, 244);

  //neutral shades
  static const Color black = Color.fromARGB(255, 1, 1, 1);
  static const Color darkerGrey = Color.fromARGB(255, 128, 121, 121);
  static const Color darkGrey = Color.fromARGB(255, 235, 210, 210);
  static const Color grey = Color.fromARGB(255, 144, 132, 132);
  static const Color softGrey = Colors.white;
  static const Color lightGrey = Color.fromARGB(255, 195, 179, 179);
  static const Color white = Colors.white;
}
