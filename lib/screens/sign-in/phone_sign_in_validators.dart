import 'package:keep_track_toolkit/utils/validators.dart';

class PhoneNumberValidator implements StringValidator {
  String get error => _error;

  String _error = "";

  @override
  bool isValid(String value) {
    _error = "";

    return true;
  }
}

class PhoneNumberValidators {
  final PhoneNumberValidator phoneNumberValidator = PhoneNumberValidator();
}
