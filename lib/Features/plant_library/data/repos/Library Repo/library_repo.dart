import 'package:dartz/dartz.dart';
import 'package:mazraaty/Core/errors/failure.dart';
import 'package:mazraaty/Features/plant_library/data/models/plant_category.dart';

abstract class PlantRepository {
  Future<Either<Failure, List<PlantCategory>>> fetchCategories();
}
