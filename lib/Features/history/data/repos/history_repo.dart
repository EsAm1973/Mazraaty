import 'dart:typed_data';

import 'package:mazraaty/Features/history/data/models/history_model.dart';
import 'package:mazraaty/Features/scan_plant/data/models/disease_details.dart';

abstract class IHistoryRepository {
  Future<void> addDiseaseToHistory(
      DiseaseDetailsModel disease, Uint8List imageBytes, int userId);
  Future<void> removeDiseaseFromHistory(int diseaseId);
  Future<List<HistoryDisease>> getHistory(int userId);
  Future<bool> isDiseaseSaved(int diseaseId, int userId);
}
