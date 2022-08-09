import 'package:keep_track_toolkit/utils/validators.dart';

class PhoneValidator implements StringValidator {
  String get error => _error;

  String _error = "";

  @override
  bool isValid(String value) {
    _error = "";
    return true;

    // RegExp exp = RegExp(r"^\+[0-9]{1,3}\.[0-9]{4,14}(?:x.+)?$");
    // RegExpMatch? match = exp.firstMatch(value);

    // if (match == null) {
    //   _error = "Phone Number is invalid";
    //   return false;
    // }
    // return _error == "";
  }
}

class OTPValidator implements StringValidator {
  String get error => _error;

  String _error = "";

  @override
  bool isValid(String value) {
    _error = "";
    return true;

    // RegExp exp = RegExp(r"^\+[0-9]{1,3}\.[0-9]{4,14}(?:x.+)?$");
    // RegExpMatch? match = exp.firstMatch(value);

    // if (match == null) {
    //   _error = "Phone Number is invalid";
    //   return false;
    // }
    // return _error == "";
  }
}

class PhoneValidators {
  final PhoneValidator phoneValidator = PhoneValidator();
  final OTPValidator otpValidator = OTPValidator();
}
