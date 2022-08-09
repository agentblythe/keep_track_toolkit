class PhoneSignInVerificationResult {
  PhoneSignInVerificationResultEnum signInResult;
  String? info;

  PhoneSignInVerificationResult({
    required this.signInResult,
    this.info,
  });
}

enum PhoneSignInVerificationResultEnum {
  signedUp,
  error,
  verified,
  timedOut,
}
