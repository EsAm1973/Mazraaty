import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mazraaty/Features/profile/data/models/profile.dart';
import 'package:mazraaty/Features/profile/data/repos/profile_repo.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.profileRepository) : super(ProfileInitial());
  final ProfileRepository profileRepository;

  Future<void> fetchProfile({
    required String token,
  }) async {
    emit(ProfileLoading());
    final result = await profileRepository.getProfile(
      token: token,
    );
    result.fold(
      (failure) => emit(ProfileError(message: failure.errorMessage)),
      (profile) => emit(ProfileLoaded(profile: profile)),
    );
  }

  Future<void> updateProfileImage({
    required File image,
    required String token,
  }) async {
    emit(ProfileLoading());
    final result = await profileRepository.updateProfileImage(
      token: token,
      image: image,
    );
    result.fold(
      (failure) => emit(ProfileError(message: failure.errorMessage)),
      (profile) => emit(ProfileLoaded(profile: profile)),
    );
  }
}
