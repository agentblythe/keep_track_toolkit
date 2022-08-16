import 'package:flutter/material.dart';
import 'package:keep_track_toolkit/services/auth.dart';
//enum SignInType { password, social, phone }

// class ProfileChangeValidators {
//   final EmailValidator emailValidator = EmailValidator();
//   final PhoneValidator phoneValidator = PhoneValidator();
// }

class ProfileChangeModel with ChangeNotifier {
  //String? photoURL;
  String? displayName;
  // String? email;
  // String? phone;
  // SignInType? signInType;
  bool isLoading = false;
  AuthBase auth;

  ProfileChangeModel({
    //required this.photoURL,
    required this.displayName,
    // required this.email,
    // required this.phone,
    // required this.signInType,
    required this.auth,
  });

  // SignInType _getSignInType(String providerId) {
  //   if (providerId == "password") {
  //     return SignInType.password;
  //   } else if (providerId == "social") {
  //     return SignInType.social;
  //   } else {
  //     return SignInType.phone;
  //   }
  // }

  void updateWith({
    //String? photoURL,
    String? displayName,
    // String? email,
    // String? phone,
    bool? isLoading,
  }) {
    //this.photoURL = photoURL ?? this.photoURL;
    this.displayName = displayName ?? this.displayName;
    // this.email = email ?? this.email;
    // this.phone = phone ?? this.phone;
    this.isLoading = isLoading ?? this.isLoading;
    notifyListeners();
  }

  // bool get submitEnabled {
  //   bool result = true;
  //   if ((_emailRequired || _emailHasChanged) && (email != null)) {
  //     result = emailValidator.isValid(email!);
  //   }
  //   if ((_phoneRequired || _phoneHasChanged) && (phone != null)) {
  //     result = result && phoneValidator.isValid(phone!);
  //   }
  //   return result && !isLoading;
  // }

  // bool get _emailRequired => signInType == SignInType.password;

  // String? get emailErrorText {
  //   if (_emailRequired || _emailHasChanged) {
  //     if (email == null || !emailValidator.isValid(email!)) {
  //       return emailValidator.error;
  //     }
  //   }
  //   return null;
  // }

  // bool get _phoneRequired => signInType == SignInType.phone;

  // String? get phoneErrorText {
  //   if (_phoneRequired || _phoneHasChanged) {
  //     if (phone == null || !phoneValidator.isValid(phone!)) {
  //       return phoneValidator.error;
  //     }
  //   }
  //   return null;
  // }

  // bool get _emailHasChanged => user.email != email;

  // bool get _phoneHasChanged => user.phoneNumber != phone;

  // bool get _displayNameHasChanged => user.displayName != displayName;

  Future<void> submit() async {
    updateWith(isLoading: true);

    if (auth.currentUser!.displayName != displayName) {
      auth.updateDisplayName(displayName);
    }

    updateWith(isLoading: false);

    // if (_emailHasChanged && emailErrorText == null) {
    //   await _user.updateEmail(email!);
    // }
    // if (_phoneHasChanged && phoneErrorText == null) {
    //   await _user.updatePhoneNumber(phoneCredential);
    // }
  }
}
