import 'package:keep_track_toolkit/utils/validators.dart';

class PhoneValidator implements StringValidator {
  String get error => _error;

  String _error = "";

  @override
  bool isValid(String value) {
    _error = "";

    // RegExp exp = RegExp(
    //     r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    // RegExpMatch? match = exp.firstMatch(value);

    // if (match == null) {
    //   _error = "Phone Number is invalid";
    //   return false;
    // }
    return true;
  }
}
