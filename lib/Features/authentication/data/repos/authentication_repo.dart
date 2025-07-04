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

  // Google Sign-In Method
  Future<Either<Failure, Map<String, dynamic>>> signInWithGoogle();

  // Forget Password Methods
  Future<Either<Failure, Map<String, dynamic>>> sendOtp(String email);
  Future<Either<Failure, Map<String, dynamic>>> verifyOtp(
      String email, String otp);
  Future<Either<Failure, Map<String, dynamic>>> resetPassword(
      String email, String otp, String newPassword);
}
