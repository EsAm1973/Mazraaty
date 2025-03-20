import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mazraaty/Core/errors/failure.dart';
import 'package:mazraaty/Core/utils/api_service.dart';
import 'package:mazraaty/Features/scan_plant/data/models/disease_details.dart';
import 'package:mazraaty/Features/scan_plant/data/repos/Disease%20Details%20Repo/disease_details_repo.dart';

class DiseaseRepositoryImpl implements DiseaseRepository {
  final ApiService apiService;

  DiseaseRepositoryImpl({required this.apiService});

  @override
  Future<Either<Failure, DiseaseDetailsModel>> fetchDiseaseDetails(
      String diseaseName) async {
    const String endPoint = 'diseases';
    final Map<String, dynamic> params = {'name': diseaseName};
    final Map<String, dynamic> headers = {'Accept': 'application/json'};

    try {
      final response = await apiService.dio.get(
        endPoint,
        queryParameters: params,
        options: Options(headers: headers),
      );
      if (response.data['status'] != 'success') {
        return Left(ServerFailure(errorMessage: response.data['message']));
      } else {
        final details = DiseaseDetailsModel.fromJson(response.data);
        return Right(details);
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
