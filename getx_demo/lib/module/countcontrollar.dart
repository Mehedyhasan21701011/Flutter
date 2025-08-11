import 'package:flutter/material.dart';

class Countcontrollar extends ChangeNotifier {
  int _COUNT = 0;
  Countcontrollar(this._COUNT);

  int get count => _COUNT;

  void increment() {
    _COUNT++;
    notifyListeners();
  }
    void decrement() {
    _COUNT--;
    notifyListeners();
  }
}
