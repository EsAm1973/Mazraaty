import 'package:dartz/dartz.dart';
import 'package:mazraaty/Core/errors/failure.dart';

abstract class AuthenticationRepo {
  Future<Either<Failure, Map<String, dynamic>>> login(
      {required String email, required String password});
  Future<Either<Failure, Map<String, dynamic>>> register({
    required String username,
    required String phone,
    required String email,
    required String password,
  });
}
