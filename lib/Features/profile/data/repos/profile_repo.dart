import 'package:dartz/dartz.dart';
import 'package:mazraaty/Core/errors/failure.dart';
import 'package:mazraaty/Features/profile/data/models/profile.dart';

abstract class ProfileRepository {
  Future<Either<Failure, Profile>> getProfile({
    required String token,
  });
}
