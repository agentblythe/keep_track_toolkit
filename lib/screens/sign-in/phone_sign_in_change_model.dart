import 'package:flutter/foundation.dart';
import 'package:keep_track_toolkit/screens/sign-in/phone_sign_in_validators.dart';
import 'package:keep_track_toolkit/screens/sign-in/phone_sign_in_verification_result.dart';
import 'package:keep_track_toolkit/services/auth.dart';

class PhoneSignInChangeModel with PhoneValidators, ChangeNotifier {
  final AuthBase auth;
  String phone;
  bool isLoading;
  bool submitted;
  bool hidePassword;
  String verificationId;
  String otp;

  PhoneSignInChangeModel({
    required this.auth,
    this.phone = "",
    this.isLoading = false,
    this.submitted = false,
    this.hidePassword = true,
    this.verificationId = "",
    this.otp = "",
  });

  bool get phoneNumberVerified => verificationId != "";

  bool get submitEnabled {
    if (verificationId == "") {
      return phoneValidator.isValid(phone) && !isLoading;
    } else {
      return otpValidator.isValid(otp) && !isLoading;
    }
  }

  String? get phoneErrorText =>
      !phoneValidator.isValid(phone) ? phoneValidator.error : null;

  String get buttonText {
    if (verificationId == "") {
      return "Verify Phone Number";
    } else {
      return "Submit OTP Code";
    }
  }

  void updatePhone(String phone) => updateWith(phone: phone);

  void updateOTP(String otp) => updateWith(otp: otp);

  Future<void> verifyPhoneNumber() async {
    updateWith(submitted: true, isLoading: true);
    try {
      var verificationResult = await auth.verifyPhoneNumber(phone);
      if (verificationResult.signInResult ==
          PhoneSignInVerificationResultEnum.verified) {
        updateWith(verificationId: verificationResult.info, isLoading: false);
      }
    } catch (e) {
      updateWith(isLoading: false);
      rethrow;
    }
  }

  Future<void> submit(String verificationID, String otp) async {
    updateWith(isLoading: true);
    try {
      await auth.signInWithPhone(verificationID, otp);
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
    String? verificationId,
    String? otp,
  }) {
    this.phone = phone ?? this.phone;
    this.isLoading = isLoading ?? this.isLoading;
    this.submitted = submitted ?? this.submitted;
    this.hidePassword = hidePassword ?? this.hidePassword;
    this.verificationId = verificationId ?? this.verificationId;
    this.otp = otp ?? this.otp;

    notifyListeners();
  }
}
