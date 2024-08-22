import 'package:flutter/cupertino.dart';

class ProductDetailsModel extends ChangeNotifier{
  final Map<String, String> sizes = {
    "S": "499",
    "M": "499",
    "L": "550",
    "XL": "599",
    "XXL": "650"
  };

  Map<String,String> get getSizes=> sizes;


  String? _selectedKey;

  String? get getSelectedKey=>_selectedKey;

  set setKey(value){
    _selectedKey=value;
    notifyListeners();
  }


  int _selectedQuantity = 1;

  int get selectedQuantity => _selectedQuantity;

  set selectedQuantity(int value) {
    _selectedQuantity = value;
    notifyListeners();
  }
}