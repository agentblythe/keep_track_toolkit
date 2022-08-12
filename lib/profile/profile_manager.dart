import 'package:flutter/material.dart';

class ProfileManager extends ChangeNotifier {
  bool get darkMode => _darkMode;
  var _darkMode = false;

  set darkMode(bool darkMode) {
    _darkMode = darkMode;
    notifyListeners();
  }
}
