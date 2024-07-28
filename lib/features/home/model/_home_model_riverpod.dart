import 'package:flutter/material.dart';

class HomeModelRiverpod extends ChangeNotifier {
  int _selected = 0;

  int get selected => _selected;

  set selected(value) {
    _selected = value;
    notifyListeners();
  }
}
