import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keep_track_toolkit/screens/profile/profile_change_model.dart';

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

  ProfileCubit({
    required this.user,
  }) : super(ProfileChangeModel(
          displayName: user.displayName,
          signInType: _getSignInType(user),
        ));

  void updateDisplayName(String? displayName) {
    emit(state.copyWith(displayName: displayName));
  }

  void updateIsLoading(bool isLoading) {
    emit(state.copyWith(isLoading: isLoading));
  }
}
