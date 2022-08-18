import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keep_track_toolkit/screens/profile/profile_change_model.dart';

import '../../services/auth.dart';

SignInType _getSignInType(User user) {
  String providerId = user.providerData.first.providerId;
  if (providerId == "password") {
    return SignInType.password;
  } else if (providerId == "social") {
    return SignInType.social;
  } else {
    return SignInType.phone;
  }
}

class ProfileCubit extends Cubit<ProfileChangeModel> {
  User user;
  AuthBase auth;

  ProfileCubit({
    required this.user,
    required this.auth,
  }) : super(ProfileChangeModel(
          displayName: user.displayName,
          email: user.email,
          signInType: _getSignInType(user),
        ));

  void updateDisplayName(String? displayName) {
    emit(state.copyWith(
      displayName: displayName,
      displayNameHasChanged: user.displayName != displayName,
    ));
  }

  void updateEmail(String? email) {
    emit(state.copyWith(
      email: email,
      emailHasChanged: user.email != email,
    ));
  }

  void updateIsLoading(bool isLoading) {
    emit(state.copyWith(isLoading: isLoading));
  }

  void resetState() {
    emit(state.copyWith(
      displayName: user.displayName,
      displayNameHasChanged: false,
      email: user.email,
      emailHasChanged: false,
      isLoading: false,
      signInType: _getSignInType(user),
    ));
  }

  Future<void> submit() async {
    updateIsLoading(true);

    try {
      if (state.displayNameHasChanged) {
        await auth.updateDisplayName(state.displayName);
      }
      if (state.emailHasChanged) {
        await auth.updateEmail(state.email);
      }
    } catch (e) {
      rethrow;
    } finally {
      updateIsLoading(false);
    }
  }
}
