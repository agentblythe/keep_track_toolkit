import 'package:flutter/foundation.dart';
import 'package:keep_track_toolkit/screens/sign-in/phone_sign_in_validators.dart';
import 'package:keep_track_toolkit/services/auth.dart';

class PhoneSignInChangeModel with PhoneNumberValidators, ChangeNotifier {
  final AuthBase auth;
  String phoneNumber;
  bool isLoading;
  bool submitted;
  bool hidePassword;

  PhoneSignInChangeModel({
    required this.auth,
    this.phoneNumber = "",
    this.isLoading = false,
    this.submitted = false,
    this.hidePassword = true,
  });

  bool get submitEnabled =>
      phoneNumberValidator.isValid(phoneNumber) && !isLoading;

  String? get phoneNumberErrorText =>
      !phoneNumberValidator.isValid(phoneNumber) && submitted
          ? phoneNumberValidator.error
          : null;

  void updatePhoneNumber(String phoneNumber) =>
      updateWith(phoneNumber: phoneNumber);

  Future<void> submit() async {
    updateWith(submitted: true, isLoading: true);

    try {
      await auth.signInWithPhoneNumber(phoneNumber);
    } catch (e) {
      updateWith(isLoading: false);
      rethrow;
    }
  }

  void updateWith({
    String? phoneNumber,
    bool? isLoading,
    bool? submitted,
    bool? hidePassword,
  }) {
    this.phoneNumber = phoneNumber ?? this.phoneNumber;
    this.isLoading = isLoading ?? this.isLoading;
    this.submitted = submitted ?? this.submitted;
    this.hidePassword = hidePassword ?? this.hidePassword;
    notifyListeners();
  }
}
