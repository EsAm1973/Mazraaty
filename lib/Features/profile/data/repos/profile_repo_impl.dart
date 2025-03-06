import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mazraaty/Core/errors/failure.dart';
import 'package:mazraaty/Core/utils/api_service.dart';
import 'package:mazraaty/Features/profile/data/models/profile.dart';
import 'package:mazraaty/Features/profile/data/repos/profile_repo.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ApiService apiService;

  ProfileRepositoryImpl({required this.apiService});

  @override
  Future<Either<Failure, Profile>> getProfile({
    required String token,
  }) async {
    // تحضير الهيدر المطلوب
    final headers = {
      'Accept': 'application/json',
      'Accept-Language': 'en',
      'Authorization': 'Bearer $token',
    };
    try {
      // استدعاء ال ApiService مع endpoint المناسب (مثلاً: '/profile')
      final response = await apiService.get('profile', headers: headers);

      if (response['status'] == 'success') {
        // تحليل البيانات وإنشاء الـ Profile Model
        final profile = Profile.fromJson(response);
        return Right(profile);
      } else {
        // إذا كانت الحالة ليست success يتم إعادة Failure
        return Left(ServerFailure(errorMessage: response['message']));
      }
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      } else {
        return Left(ServerFailure(errorMessage: e.toString()));
      }
    }
  }
}
