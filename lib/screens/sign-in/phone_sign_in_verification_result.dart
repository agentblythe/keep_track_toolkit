class PhoneSignInVerificationResult {
  PhoneSignInVerificationResultEnum signInResult;
  String? info;

  PhoneSignInVerificationResult({
    required this.signInResult,
    this.info,
  });
}

enum PhoneSignInVerificationResultEnum {
  SignedUp,
  Error,
  Verified,
  TimedOut,
}
