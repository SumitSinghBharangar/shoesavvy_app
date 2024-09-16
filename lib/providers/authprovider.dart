import 'package:flutter/material.dart';

class AuthViewModel with ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;
  bool _signuploading = false;
  bool get signuploading => _signuploading;

  setloading(bool value) {
    _loading = value;
    notifyListeners();
  }

  setsignuploading(bool value) {
    _signuploading = value;
    notifyListeners();
  }
}
