import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mazraaty/Core/errors/failure.dart';
import 'package:mazraaty/Core/utils/api_service.dart';
import 'package:mazraaty/Features/payment/data/models/package.dart';
import 'package:mazraaty/Features/payment/data/repos/Package%20Repo/package_repo.dart';

class PackagesRepositoryImpl implements PackagesRepository {
  final ApiService apiService;

  PackagesRepositoryImpl({required this.apiService});

  @override
  Future<Either<Failure, List<Package>>> getPackages({
    String currency = 'USD',
    String? token,
  }) async {
    try {
      // Prepare headers with Accept, Accept-Language, Currency and Authorization if token is provided
      Map<String, dynamic> headers = {
        'Accept': 'application/json',
        'Accept-Language': 'en',
        'Currency': currency,
      };

      // Add Authorization header if token is provided
      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }

      // Make API call with headers
      final response = await apiService.get(
        'packages',
        headers: headers,
      );

      if (response['status'] == 'success') {
        final List<dynamic> packagesData = response['data'];
        final List<Package> packages = packagesData
            .map((packageJson) => Package.fromJson(packageJson))
            .toList();

        return Right(packages);
      } else {
        return Left(ServerFailure(
            errorMessage: response['message'] ?? 'Failed to get packages'));
      }
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }
}
