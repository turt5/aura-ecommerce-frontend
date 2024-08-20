import 'package:attira/services/user/firebase/_user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeModelRiverpod extends ChangeNotifier {
  int _selected = 0;

  int get selected => _selected;

  set selected(int value) {
    _selected = value;
    notifyListeners();
  }

  Future<Map<String, dynamic>> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return {
      'userId': prefs.getString('userId'),
      'name': prefs.getString('name'),
      'email': prefs.getString('email'),
      'phone': prefs.getString('phone'),
      'role': prefs.getString('role'),
      'imageUrl': prefs.getString('imageUrl'),
    };
  }

  Stream<List<Users>> getAllUsers() {
    FirebaseService firebaseService = FirebaseService();
    return firebaseService.getAllUsersData();
  }
}
