import 'package:flutter/material.dart';

class Themecontroler extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get thememode => _themeMode;

  void setTheme(ThemeMode x) {
    _themeMode = x;
    notifyListeners();
  }
}
