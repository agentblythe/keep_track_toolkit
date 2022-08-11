import 'package:flutter/material.dart';
import 'package:keep_track_toolkit/services/auth.dart';

class SignInManager {
  final AuthBase auth;
  final ValueNotifier<bool> isLoading;

  SignInManager({
    required this.auth,
    required this.isLoading,
  });

  Future<void> _signIn(Future<void> Function() signInMethod) async {
    try {
      isLoading.value = true;
      await signInMethod();
    } catch (e) {
      isLoading.value = false;
      rethrow;
    }
  }

  Future<void> signInWithGoogle() async => await _signIn(auth.signInWithGoogle);

  Future<void> signInWithFacebook() async =>
      await _signIn(auth.signInWithFacebook);

  Future<void> signInWithTwitter() async =>
      await _signIn(auth.signInWithTwitter);
}
