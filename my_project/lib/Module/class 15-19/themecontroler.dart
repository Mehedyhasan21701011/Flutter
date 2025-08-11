import 'package:flutter/material.dart';

class Themecontroler extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  void toggleThemeMode() {
    // _themeMode = _themeMode == ThemeMode.light? ThemeMode.dark : ThemeMode.light;
    if (_themeMode == ThemeMode.light) {
      _themeMode = ThemeMode.dark;
    }else{
      _themeMode = ThemeMode.light;
    }
    notifyListeners();
  }
}
