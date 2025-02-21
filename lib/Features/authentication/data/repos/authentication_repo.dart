import 'package:dartz/dartz.dart';

abstract class AuthenticationRepo {
  Future<Either<Failure, Map<String, dynamic>>> login(
      {required String email, required String password});
}
