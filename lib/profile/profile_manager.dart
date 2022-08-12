import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileManager extends ChangeNotifier {
  User appUser;

  ProfileManager({
    required this.appUser,
  });

  bool get darkMode => _darkMode;
  var _darkMode = false;

  set darkMode(bool darkMode) {
    _darkMode = darkMode;
    notifyListeners();
  }
}
