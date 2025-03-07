import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:mazraaty/Core/errors/failure.dart';
import 'package:mazraaty/Features/profile/data/models/profile.dart';

abstract class ProfileRepository {
  Future<Either<Failure, Profile>> getProfile({
    required String token,
  });

  Future<Either<Failure,Profile>> updateProfileImage({
    required String token,
    required File image,
  });
}
