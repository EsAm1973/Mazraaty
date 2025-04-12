// history_disease_model.dart

import 'package:mazraaty/Features/scan_plant/data/models/disease_image.dart';
import 'package:mazraaty/Features/scan_plant/data/models/home_remedy.dart';
import 'package:mazraaty/Features/scan_plant/data/models/prevention.dart';
import 'package:mazraaty/Features/scan_plant/data/models/soluation.dart';
import 'package:mazraaty/Features/scan_plant/data/models/symptom.dart';

class HistoryDisease {
  final int diseaseId;
  final String name;
  final String originName;
  final String scientificName;
  final String alsoKnowAs;
  final String typeDisease;
  final String description;
  final List<Symptom> symptoms;
  final List<Solution> solutions;
  final List<Prevention> preventions;
  final List<HomeRemedy> homeRemedys;
  final List<DiseaseImage> diseaseImages;
  final int repetitions;
  final String? imageHistory; // URL of the saved image from server

  HistoryDisease({
    required this.diseaseId,
    required this.name,
    required this.originName,
    required this.scientificName,
    required this.alsoKnowAs,
    required this.typeDisease,
    required this.description,
    required this.symptoms,
    required this.solutions,
    required this.preventions,
    required this.homeRemedys,
    required this.diseaseImages,
    this.repetitions = 0,
    this.imageHistory,
  });

  factory HistoryDisease.fromJson(Map<String, dynamic> json) {
    return HistoryDisease(
      diseaseId: json['id'] ?? 0,
      name: json['name'] ?? '',
      originName: json['origin_name'] ?? '',
      scientificName: json['scientific_name'] ?? '',
      alsoKnowAs: json['also_know_as'] ?? '',
      typeDisease: json['type_disease'] ?? '',
      description: json['description'] ?? '',
      symptoms: (json['symptoms'] as List<dynamic>? ?? [])
          .map((e) => Symptom.fromJson(e))
          .toList(),
      solutions: (json['solutions'] as List<dynamic>? ?? [])
          .map((e) => Solution.fromJson(e))
          .toList(),
      preventions: (json['preventions'] as List<dynamic>? ?? [])
          .map((e) => Prevention.fromJson(e))
          .toList(),
      homeRemedys: (json['homeRemedys'] as List<dynamic>? ?? [])
          .map((e) => HomeRemedy.fromJson(e))
          .toList(),
      diseaseImages: (json['disease_images'] as List<dynamic>? ?? [])
          .map((e) => DiseaseImage.fromJson(e))
          .toList(),
      repetitions: json['repetitions'] ?? 0,
      imageHistory: json['image_history'] as String?,
    );
  }
}

class HistoryResponse {
  final String status;
  final String message;
  final List<HistoryDisease> data;

  HistoryResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory HistoryResponse.fromJson(Map<String, dynamic> json) {
    return HistoryResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>? ?? [])
          .map((e) => HistoryDisease.fromJson(e))
          .toList(),
    );
  }
}

class SaveDiseaseResponse {
  final String status;
  final String message;

  SaveDiseaseResponse({
    required this.status,
    required this.message,
  });

  factory SaveDiseaseResponse.fromJson(Map<String, dynamic> json) {
    return SaveDiseaseResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
    );
  }
}
