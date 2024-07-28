import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AccountModel extends ChangeNotifier{
   XFile? _imageFile;

  XFile? get imageFile => _imageFile;

  void setImageFile(XFile? imageFile){
    _imageFile = imageFile;
    notifyListeners();
  }
}
