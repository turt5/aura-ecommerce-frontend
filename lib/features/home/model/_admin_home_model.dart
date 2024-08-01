import 'package:flutter/cupertino.dart';

class AdminHomeModel extends ChangeNotifier{
  int _selected = 0;

  int get selected => _selected;

  set selected(int value) {
    _selected = value;
    notifyListeners();
  }
}