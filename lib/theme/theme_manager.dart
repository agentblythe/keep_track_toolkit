import 'package:flutter/material.dart';

class ThemeManager extends ChangeNotifier {
  bool get darkMode => _darkMode;
  var _darkMode = false;

  set darkMode(bool darkMode) {
    _darkMode = darkMode;
    notifyListeners();
  }
}
