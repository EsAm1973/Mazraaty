import 'package:dartz/dartz.dart';
import 'package:mazraaty/Core/errors/failure.dart';
import 'package:mazraaty/Features/scan_plant/data/models/disease_details.dart';

abstract class DiseaseRepository {
  Future<Either<Failure, DiseaseDetailsModel>> fetchDiseaseDetails(String diseaseName);
}