import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeModelRiverpod extends ChangeNotifier {
  int _selected = 0;

  int get selected => _selected;

  set selected(value) {
    _selected = value;
    notifyListeners();
  }

  Future<Map<String, dynamic>> getUserData() async{
    SharedPreferences prefs= await SharedPreferences.getInstance();

    return{
      'userId':prefs.get('userId'),
      'name':prefs.get('name'),
      'email':prefs.get('email'),
      'phone':prefs.get('phone'),
      'role':prefs.get('role'),
      'imageUrl':prefs.get('imageUrl'),
    };
  }

}
