import 'dart:typed_data';

import 'package:mazraaty/Core/methods/compress_method.dart';
import 'package:mazraaty/Features/history/data/database/history_database.dart';
import 'package:mazraaty/Features/history/data/models/history_model.dart';
import 'package:mazraaty/Features/history/data/repos/history_repo.dart';
import 'package:mazraaty/Features/scan_plant/data/models/disease_details.dart';

class HistoryRepository implements IHistoryRepository {
  final HistoryDatabase _database = HistoryDatabase();

  @override
  Future<void> addDiseaseToHistory(
      DiseaseDetailsModel disease, Uint8List imageBytes, int userId) async {
    // ضغط الصورة
    final compressedImageBytes = await compressImage(imageBytes);
    // حفظ الصورة في النظام والحصول على مسارها
    final imagePath =
        await saveImageFile(compressedImageBytes, disease.id, userId);

    final historyDisease = HistoryDisease(
      diseaseId: disease.id, // استخدام الحقل diseaseId بدلاً من id
      name: disease.name,
      originName: disease.originName,
      scientificName: disease.scientificName,
      alsoKnowAs: disease.alsoKnowAs,
      typeDisease: disease.typeDisease,
      description: disease.description,
      symptoms: disease.symptoms,
      solutions: disease.solutions,
      preventions: disease.preventions,
      homeRemedys: disease.homeRemedys,
      diseaseImages: disease.diseaseImages,
      imagePath: imagePath, // حفظ مسار الصورة
      userId: userId,
    );

    await _database.insertDisease(historyDisease);
  }

  @override
  Future<void> removeDiseaseFromHistory(int diseaseId, int userId) async {
    await _database.deleteDisease(diseaseId, userId);
  }

  @override
  Future<List<HistoryDisease>> getHistory(int userId) async {
    return await _database.getDiseasesForUser(userId);
  }

  @override
  Future<bool> isDiseaseSaved(int diseaseId, int userId) async {
    final diseases = await _database.getDiseasesForUser(userId);
    return diseases.any((disease) => disease.diseaseId == diseaseId);
  }
}
