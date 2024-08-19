import 'package:attira/services/products/firebase/_product_service.dart';
import 'package:flutter/cupertino.dart';

class AdminProductAddModel extends ChangeNotifier{

  Category? _selectedCategory;

  Category? get selectedCategory => _selectedCategory;

  set setSelectedCategory(Category? value) {
    _selectedCategory = value;
    notifyListeners();
  }
}