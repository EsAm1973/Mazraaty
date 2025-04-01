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
  Future<Either<Failure, List<Package>>> getPackages() async {
    try {
      final response = await apiService.get('packages');
      
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