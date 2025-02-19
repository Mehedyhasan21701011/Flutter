import 'package:demo_project/utils/theme/appbartheme.dart';
import 'package:demo_project/utils/theme/bottomsheettheme.dart';
import 'package:demo_project/utils/theme/checkboxtheme.dart';
import 'package:demo_project/utils/theme/chiptheme.dart';
import 'package:demo_project/utils/theme/elevatedButtonTheme.dart';
import 'package:demo_project/utils/theme/textTheme.dart';
import 'package:demo_project/utils/theme/textfieldtheme.dart';
import 'package:flutter/material.dart';

class TAppTheme {
  TAppTheme._();
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: "Poppins",
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    textTheme: TTextTheme.lightTextTheme,
    elevatedButtonTheme: TElevatedbuttontheme.lightButtonTheme,
    appBarTheme: TAppBarTheme.lightAppBarTheme,
    bottomSheetTheme: TBottomSheetTheme.lightBottomSheetTheme,
    checkboxTheme: TCheckBoxTheme.lightCheckBoxTheme,
    chipTheme: TChipTheme.lightChipTheme,
    inputDecorationTheme: Textfieldtheme.lightTextFieldTheme,
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: "Poppins",
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.black,
    textTheme: TTextTheme.darkTextTheme,
    elevatedButtonTheme: TElevatedbuttontheme.darkButtonTheme,
    appBarTheme: TAppBarTheme.darkAppBarTheme,
    bottomSheetTheme: TBottomSheetTheme.darkBottomSheetTheme,
    checkboxTheme: TCheckBoxTheme.darkCheckBoxTheme,
    chipTheme: TChipTheme.darkChipTheme,
    inputDecorationTheme: Textfieldtheme.darkTextFieldTheme,
  );
}
