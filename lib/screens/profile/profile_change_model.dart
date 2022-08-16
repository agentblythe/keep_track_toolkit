import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:keep_track_toolkit/screens/sign-in/email_sign_in_validators.dart';
import 'package:keep_track_toolkit/screens/sign-in/phone_sign_in_validators.dart';

enum SignInType { password, social, phone }

class ProfileChangeValidators {
  final EmailValidator emailValidator = EmailValidator();
  final PhoneValidator phoneValidator = PhoneValidator();
}

class ProfileChangeModel with ProfileChangeValidators, ChangeNotifier {
  final User user;

  String? photoURL;
  String? displayName;
  String? email;
  String? phone;
  SignInType? signInType;
  bool isLoading = false;

  ProfileChangeModel({
    required this.user,
  }) {
    photoURL = user.photoURL;
    displayName = user.displayName;
    email = user.email;
    phone = user.phoneNumber;
    signInType = _getSignInType(user.providerData.first.providerId);
  }

  SignInType _getSignInType(String providerId) {
    if (providerId == "password") {
      return SignInType.password;
    } else if (providerId == "social") {
      return SignInType.social;
    } else {
      return SignInType.phone;
    }
  }

  void updateWith({
    String? photoURL,
    String? displayName,
    String? email,
    String? phone,
    bool? isLoading,
  }) {
    this.photoURL = photoURL ?? this.photoURL;
    this.displayName = displayName ?? this.displayName;
    this.email = email ?? this.email;
    this.phone = phone ?? this.phone;
    this.isLoading = isLoading ?? this.isLoading;
    notifyListeners();
  }

  bool get submitEnabled {
    bool result = true;
    if ((_emailRequired || _emailHasChanged) && (email != null)) {
      result = emailValidator.isValid(email!);
    }
    if ((_phoneRequired || _phoneHasChanged) && (phone != null)) {
      result = result && phoneValidator.isValid(phone!);
    }
    return result && !isLoading;
  }

  bool get _emailRequired => signInType == SignInType.password;

  String? get emailErrorText {
    if (_emailRequired || _emailHasChanged) {
      if (email == null || !emailValidator.isValid(email!)) {
        return emailValidator.error;
      }
    }
    return null;
  }

  bool get _phoneRequired => signInType == SignInType.phone;

  String? get phoneErrorText {
    if (_phoneRequired || _phoneHasChanged) {
      if (phone == null || !phoneValidator.isValid(phone!)) {
        return phoneValidator.error;
      }
    }
    return null;
  }

  bool get _emailHasChanged => user.email != email;

  bool get _phoneHasChanged => user.phoneNumber != phone;

  bool get _displayNameHasChanged => user.displayName != displayName;

  Future<void> submit() async {
    updateWith(isLoading: true);

    if (_displayNameHasChanged) {
      //await auth.updateDisplayName(displayName);
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
