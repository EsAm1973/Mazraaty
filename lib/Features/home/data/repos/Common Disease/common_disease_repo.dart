import 'package:dartz/dartz.dart';
import 'package:mazraaty/Core/errors/failure.dart';
import 'package:mazraaty/Features/home/data/models/common_disease.dart';

abstract class CommonDiseaseRepository {
  Future<Either<Failure, List<DiseaseModel>>> fetchDiseases(String token);
}
