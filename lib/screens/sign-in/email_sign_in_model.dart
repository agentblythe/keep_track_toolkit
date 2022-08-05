import 'package:keep_track_toolkit/screens/sign-in/email_sign_in_validators.dart';

enum EmailSignInFormType {
  signIn,
  register,
}

class EmailSignInModel with EmailAndPasswordValidators {
  final String email;
  final String password;
  final EmailSignInFormType formType;
  final bool isLoading;
  final bool submitted;
  final bool hidePassword;

  EmailSignInModel({
    this.email = "",
    this.password = "",
    this.formType = EmailSignInFormType.signIn,
    this.isLoading = false,
    this.submitted = false,
    this.hidePassword = true,
  });

  String get primaryButtonText =>
      formType == EmailSignInFormType.signIn ? "Sign in" : "Register";

  String get secondaryButtonText => formType == EmailSignInFormType.signIn
      ? "Need an account? Register"
      : "Already have an account? Sign in";

  bool get submitEnabled =>
      emailValidator.isValid(email) &&
      passwordValidator.isValid(password) &&
      !isLoading;

  bool get restPasswordEnabled => emailValidator.isValid(email) && !isLoading;

  String? get emailErrorText =>
      !emailValidator.isValid(email) && submitted ? emailValidator.error : null;

  String? get passwordErrorText {
    if (!passwordValidator.isValid(password)) {
      if (formType == EmailSignInFormType.signIn) {
        if (submitted) {
          return passwordValidator.error;
        }
      } else {
        return passwordValidator.error;
      }
    }
    return null;
  }

  EmailSignInModel copyWith({
    String? email,
    String? password,
    EmailSignInFormType? formType,
    bool? isLoading,
    bool? submitted,
    bool? hidePassword,
  }) {
    return EmailSignInModel(
      email: email ?? this.email,
      password: password ?? this.password,
      formType: formType ?? this.formType,
      isLoading: isLoading ?? this.isLoading,
      submitted: submitted ?? this.submitted,
      hidePassword: hidePassword ?? this.hidePassword,
    );
  }
}
