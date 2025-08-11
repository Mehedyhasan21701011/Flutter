import 'package:flutter/material.dart';

class Controlar extends ChangeNotifier {
  int Count = 0;
  int get count => Count;

  void increment() {
    Count++;
    notifyListeners();
  }

  void decrement() {
    if (Count > 0) {
      Count--;
      notifyListeners();
    }
  }

  void reset() {
    Count = 0;
    notifyListeners();
  }
}
