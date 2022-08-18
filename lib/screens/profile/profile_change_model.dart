import 'package:keep_track_toolkit/screens/sign-in/email_sign_in_validators.dart';
import 'package:keep_track_toolkit/screens/sign-in/phone_sign_in_validators.dart';

enum SignInType { password, social, phone }

class ProfileChangeValidators {
  final EmailValidator emailValidator = EmailValidator();
  final PhoneValidator phoneValidator = PhoneValidator();
}

class ProfileChangeModel with ProfileChangeValidators {
  String? displayName;
  String? email;
  bool isLoading = false;
  SignInType? signInType;

  bool displayNameHasChanged = false;
  bool emailHasChanged = false;

  ProfileChangeModel({
    this.displayName,
    this.email,
    this.isLoading = false,
    this.signInType,
    this.displayNameHasChanged = false,
    this.emailHasChanged = false,
  });

  ProfileChangeModel copyWith({
    String? displayName,
    String? email,
    bool? isLoading,
    SignInType? signInType,
    bool? displayNameHasChanged,
    bool? emailHasChanged,
  }) {
    return ProfileChangeModel(
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      isLoading: isLoading ?? this.isLoading,
      signInType: signInType ?? this.signInType,
      displayNameHasChanged:
          displayNameHasChanged ?? this.displayNameHasChanged,
      emailHasChanged: emailHasChanged ?? this.emailHasChanged,
    );
  }

  bool get _noChanges {
    return !displayNameHasChanged && !emailHasChanged;
  }

  bool get submitEnabled {
    return !isLoading && !_noChanges;
  }

  bool get emailEnabled {
    if (signInType == SignInType.social) {
      return false;
    }
    return (!isLoading);
  }
}
