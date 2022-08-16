import 'package:keep_track_toolkit/screens/sign-in/email_sign_in_validators.dart';
import 'package:keep_track_toolkit/screens/sign-in/phone_sign_in_validators.dart';

enum SignInType { password, social, phone }

class ProfileChangeValidators {
  final EmailValidator emailValidator = EmailValidator();
  final PhoneValidator phoneValidator = PhoneValidator();
}

class ProfileChangeModel with ProfileChangeValidators {
  String? displayName;
  bool isLoading = false;
  SignInType? signInType;

  ProfileChangeModel({
    this.displayName,
    this.isLoading = false,
    this.signInType,
  });

  ProfileChangeModel copyWith({
    String? displayName,
    bool? isLoading,
    SignInType? signInType,
  }) {
    return ProfileChangeModel(
      displayName: displayName ?? this.displayName,
      isLoading: isLoading ?? this.isLoading,
      signInType: signInType ?? this.signInType,
    );
  }

  bool get submitEnabled => !isLoading;

  // ProfileChangeModel updateWith({
  //   String? displayName,
  //   bool? isLoading,
  // }) {
  //   this.displayName = displayName ?? this.displayName;
  //   this.isLoading = isLoading ?? this.isLoading;
  //   return this;
  // }

  // void updateWith({
  //   //String? photoURL,
  //   String? displayName,
  //   // String? email,
  //   // String? phone,
  //   bool? isLoading,
  // }) {
  //   //this.photoURL = photoURL ?? this.photoURL;
  //   this.displayName = displayName ?? this.displayName;
  //   // this.email = email ?? this.email;
  //   // this.phone = phone ?? this.phone;
  //   this.isLoading = isLoading ?? this.isLoading;
  //   //notifyListeners();
  // }

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

  // Future<void> submit() async {
  //   updateWith(isLoading: true);

  //   if (auth.currentUser!.displayName != displayName) {
  //     await auth.updateDisplayName(displayName);
  //   }

  //   updateWith(isLoading: false);

  //   // if (_emailHasChanged && emailErrorText == null) {
  //   //   await _user.updateEmail(email!);
  //   // }
  //   // if (_phoneHasChanged && phoneErrorText == null) {
  //   //   await _user.updatePhoneNumber(phoneCredential);
  //   // }
  // }
}
