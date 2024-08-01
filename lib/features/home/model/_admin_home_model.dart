import 'package:attira/services/user/firebase/_user_service.dart';
import 'package:flutter/cupertino.dart';

class AdminHomeModel extends ChangeNotifier{
  int _selected = 0;

  int get selected => _selected;

  set selected(int value) {
    _selected = value;
    notifyListeners();
  }

  Future<int> getUsersCount()async{
    FirebaseService _fs= FirebaseService();
    return await _fs.countUsers();
  }

  Future<Map<String,dynamic>> getHomeDashboardData()async{
    FirebaseService _fs= FirebaseService();

    return {
      'users': await _fs.countUsers(),
      'usersTitle': 'Registered Users',
      'products': 332,
      'productsTitle': 'Products in inventory'
    };
  }
}