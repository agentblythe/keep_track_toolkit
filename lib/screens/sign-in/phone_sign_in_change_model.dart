import 'package:flutter/foundation.dart';
import 'package:keep_track_toolkit/screens/sign-in/phone_sign_in_validators.dart';
import 'package:keep_track_toolkit/services/auth.dart';

class PhoneSignInChangeModel with PhoneValidator, ChangeNotifier {
  final AuthBase auth;
  String phone;
  bool isLoading;
  bool submitted;
  bool hidePassword;

  PhoneSignInChangeModel({
    required this.auth,
    this.phone = "",
    this.isLoading = false,
    this.submitted = false,
    this.hidePassword = true,
  });

  final PhoneValidator phoneValidator = PhoneValidator();

  bool get submitEnabled => phoneValidator.isValid(phone) && !isLoading;

  String? get phoneErrorText =>
      !phoneValidator.isValid(phone) && submitted ? phoneValidator.error : null;

  void updatePhone(String phone) => updateWith(phone: phone);

  Future<void> submit() async {
    updateWith(submitted: true, isLoading: true);
    try {
      await auth.signInWithPhone(phone);
    } catch (e) {
      updateWith(isLoading: false);
      rethrow;
    }
  }

  void updateWith({
    String? phone,
    bool? isLoading,
    bool? submitted,
    bool? hidePassword,
  }) {
    this.phone = phone ?? this.phone;
    this.isLoading = isLoading ?? this.isLoading;
    this.submitted = submitted ?? this.submitted;
    this.hidePassword = hidePassword ?? this.hidePassword;
    notifyListeners();
  }
}
