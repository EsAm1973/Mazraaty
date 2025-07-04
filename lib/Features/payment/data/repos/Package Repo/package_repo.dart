import 'package:dartz/dartz.dart';
import 'package:mazraaty/Core/errors/failure.dart';
import 'package:mazraaty/Features/payment/data/models/package.dart';

abstract class PackagesRepository {
  Future<Either<Failure, List<Package>>> getPackages({
    String currency = 'USD',
    String? token,
  });
}
