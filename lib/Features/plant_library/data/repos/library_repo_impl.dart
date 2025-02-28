import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mazraaty/Core/errors/failure.dart';
import 'package:mazraaty/Core/utils/api_service.dart';
import 'package:mazraaty/Features/plant_library/data/models/plant_category.dart';
import 'package:mazraaty/Features/plant_library/data/repos/library_repo.dart';

class PlantRepositoryImpl implements PlantRepository {
  final ApiService apiService;

  PlantRepositoryImpl(this.apiService);

  @override
  Future<Either<Failure, List<PlantCategory>>> fetchCategories() async {
    final headers = {
      'Accept-Language': 'en',
      'Accept': 'application/json',
    };
    try {
      final response = await apiService.get('search', headers: headers);
      if (response['status'] == 'error') {
        return Left(ServerFailure(errorMessage: response['message']));
      } else {
        final List<PlantCategory> categories = (response['data'] as List)
            .map((e) => PlantCategory.fromJson(e))
            .toList();
        return Right(categories);
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
