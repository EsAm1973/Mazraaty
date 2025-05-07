import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mazraaty/Core/errors/failure.dart';
import 'package:mazraaty/Core/utils/api_service.dart';
import 'package:mazraaty/Features/authentication/data/repos/authentication_repo.dart';

class AuthenticationRepoImpl implements AuthenticationRepo {
  final ApiService apiService;
  AuthenticationRepoImpl({required this.apiService});
  @override
  Future<Either<Failure, Map<String, dynamic>>> login(
      {required String email, required String password}) async {
    final body = {
      'email': email,
      'password': password,
    };
    final headers = {
      'Accept-Language': 'en',
      'Accept': 'application/json',
    };
    try {
      final response = await apiService.post('login', body, headers: headers);
      if (response['status'] == 'error') {
        return left(
          ServerFailure(
            errorMessage: response['message'],
          ),
        );
      } else {
        final userData = response['data'];
        return right(userData);
      }
    } on Exception catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      } else {
        return left(ServerFailure(errorMessage: e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> register(
      {required String username,
      required String phone,
      required String email,
      required String password}) async {
    final body = {
      'name': username,
      'phone_number': phone,
      'email': email,
      'password': password,
      'password_confirmation': password,
    };
    final headers = {
      'Accept': 'application/json',
      'Accept-Language': 'en',
    };
    try {
      final response =
          await apiService.post('register', body, headers: headers);
      if (response['status'] == 'error') {
        return left(
          ServerFailure(
            errorMessage: response['message'],
          ),
        );
      } else {
        //print(response);
        return right(response);
      }
    } on Exception catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      } else {
        return left(ServerFailure(errorMessage: e.toString()));
      }
    }
  }

  /// ======================= ///
  /// Forget Password Methods
  /// ======================= ///
  @override
  Future<Either<Failure, Map<String, dynamic>>> sendOtp(String email) async {
    final body = {'email': email};
    final headers = {
      'Accept-Language': 'en',
      'Accept': 'application/json',
    };
    try {
      final response =
          await apiService.post('password-recovery', body, headers: headers);
      if (response['status'] == 'error') {
        return left(ServerFailure(errorMessage: response['message']));
      } else {
        return right(response);
      }
    } on Exception catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      } else {
        return left(ServerFailure(errorMessage: e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> verifyOtp(
      String email, String otp) async {
    final body = {'email': email, 'otp': otp};
    final headers = {
      'Accept-Language': 'en',
      'Accept': 'application/json',
    };
    try {
      final response = await apiService.post('verify', body, headers: headers);
      if (response['status'] == 'error') {
        return left(ServerFailure(errorMessage: response['message']));
      } else {
        return right(response);
      }
    } on Exception catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      } else {
        return left(ServerFailure(errorMessage: e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> resetPassword(
      String email, String otp, String newPassword) async {
    final body = {
      'email': email,
      'otp': otp,
      'password': newPassword,
      'password_confirmation': newPassword,
    };
    final headers = {
      'Accept-Language': 'en',
      'Accept': 'application/json',
    };
    try {
      final response =
          await apiService.post('reset-password', body, headers: headers);
      if (response['status'] == 'error') {
        return left(ServerFailure(errorMessage: response['message']));
      } else {
        return right(response);
      }
    } on Exception catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      } else {
        return left(ServerFailure(errorMessage: e.toString()));
      }
    }
  }
}
