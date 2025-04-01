import 'package:dartz/dartz.dart';
import 'package:mazraaty/Core/errors/failure.dart';
import 'package:mazraaty/Features/scan_plant/data/models/points.dart';

abstract class PointsRepository {
  Future<Either<Failure, PointsModel>> fetchUserPoints(String token);
}