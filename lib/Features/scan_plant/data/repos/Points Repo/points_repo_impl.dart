import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mazraaty/Core/errors/failure.dart';
import 'package:mazraaty/Core/utils/api_service.dart';
import 'package:mazraaty/Features/scan_plant/data/models/points.dart';
import 'package:mazraaty/Features/scan_plant/data/repos/Points%20Repo/points_repo.dart';

class PointsRepositoryImpl implements PointsRepository {
  final ApiService apiService;

  PointsRepositoryImpl({required this.apiService});

  @override
  Future<Either<Failure, PointsModel>> fetchUserPoints(String token) async {
    const String endPoint = 'get-points';
    final Map<String, dynamic> headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await apiService.get(
        endPoint,
        headers: headers,
      );
      
      if (response['status'] != 'success') {
        return Left(ServerFailure(errorMessage: response['message']));
      } else {
        final points = PointsModel.fromJson(response);
        return Right(points);
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