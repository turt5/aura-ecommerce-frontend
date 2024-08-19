import 'package:attira/services/products/firebase/_product_service.dart';
import 'package:flutter/cupertino.dart';

class AdminProductAddModel extends ChangeNotifier{
  Section? _selectedSection;

  Section? get selectedSection => _selectedSection;

  set setSelectedSection(Section? value) {
    _selectedSection = value;
    notifyListeners();
  }



  Category? _selectedCategory;

  Category? get selectedCategory => _selectedCategory;

  set setSelectedCategory(Category? value) {
    _selectedCategory = value;
    notifyListeners();
  }
}