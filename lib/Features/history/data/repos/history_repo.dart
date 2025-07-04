import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:mazraaty/Core/errors/failure.dart';
import 'package:mazraaty/Features/history/data/models/history_model.dart';
import 'package:mazraaty/Features/scan_plant/data/models/disease_details.dart';

abstract class IHistoryRepository {
  Future<Either<Failure, SaveDiseaseResponse>> addDiseaseToHistory(
      DiseaseDetailsModel disease, Uint8List imageBytes, String token);
      
  Future<Either<Failure, List<HistoryDisease>>> getHistory(String token);
}
