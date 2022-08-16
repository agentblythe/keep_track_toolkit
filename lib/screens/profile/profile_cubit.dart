import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keep_track_toolkit/screens/profile/profile_change_model.dart';
import 'package:keep_track_toolkit/services/auth.dart';

class ProfileCubit extends Cubit<ProfileChangeModel> {
  User user;

  ProfileCubit({
    required this.user,
  }) : super(ProfileChangeModel(
          displayName: user.displayName,
        ));

  void updateDisplayName(String? displayName) {
    emit(state.copyWith(displayName: displayName));
  }

  void updateIsLoading(bool isLoading) {
    emit(state.copyWith(isLoading: isLoading));
  }
}
