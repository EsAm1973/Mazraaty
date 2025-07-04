import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mazraaty/Core/errors/failure.dart';
import 'package:mazraaty/Core/utils/api_service.dart';
import 'package:mazraaty/Features/home/data/models/common_disease.dart';
import 'package:mazraaty/Features/home/data/repos/Common%20Disease/common_disease_repo.dart';

class CommonDiseaseRepositoryImpl implements CommonDiseaseRepository {
  final ApiService apiService;

  CommonDiseaseRepositoryImpl({required this.apiService});

  @override
  Future<Either<Failure, List<DiseaseModel>>> fetchDiseases(
      String token) async {
    final headers = {
      'Accept': 'application/json',
      'Accept-Language': 'en',
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await apiService.get('home/index', headers: headers);
      if (response['status'] != 'success') {
        return Left(ServerFailure(errorMessage: response['message']));
      } else {
        final List<DiseaseModel> diseases = (response['data'] as List)
            .map((diseaseJson) => DiseaseModel.fromJson(diseaseJson))
            .toList();
        return Right(diseases);
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
