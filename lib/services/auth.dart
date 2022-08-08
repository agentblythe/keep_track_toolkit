import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthBase {
  User? get currentUser;
  Stream<User?> authStateChanges();
  Future<void> signInWithEmailAndPassword(String email, String password);
  Future<void> createUserWithEmailAndPassword(String email, String password);
  Future<void> resetPassword(String email);
  Future<void> signInWithGoogle();
  Future<void> signInWithFacebook();
  Future<void> signOut();
}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  User? get currentUser => _firebaseAuth.currentUser;

  @override
  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await _firebaseAuth.signInWithCredential(
      EmailAuthProvider.credential(
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> resetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<void> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      final googleAuth = await googleUser.authentication;
      if (googleAuth.idToken != null) {
        await _firebaseAuth.signInWithCredential(
          GoogleAuthProvider.credential(
            idToken: googleAuth.idToken,
            accessToken: googleAuth.accessToken,
          ),
        );
      } else {
        throw FirebaseAuthException(
          code: "GOOGLE_SIGN_IN_MISSING_ID_TOKEN",
          message: "Missing Google ID Token",
        );
      }
    } else {
      throw FirebaseAuthException(
        code: "SIGN_IN_ABORTED_BY_USER",
        message: "Google sign-in was aborted by the user",
      );
    }
  }

  @override
  Future<void> signInWithFacebook() async {
    final fb = FacebookAuth.instance;
    final response = await fb.login();

    switch (response.status) {
      case LoginStatus.success:
        final accessToken = response.accessToken;
        if (accessToken != null) {
          await _firebaseAuth.signInWithCredential(
              FacebookAuthProvider.credential(accessToken.token));
        }
        return;
      case LoginStatus.cancelled:
        throw FirebaseAuthException(
          code: "SIGN_IN_ABORTED_BY_USER",
          message: "Facebook sign-in was aborted by the user",
        );
      case LoginStatus.failed:
        throw FirebaseAuthException(
          code: "FACEBOOK_SIGN_IN_FAILED",
          message: response.message,
        );
      default:
        throw UnimplementedError();
    }
  }
}
