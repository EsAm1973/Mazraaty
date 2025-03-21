// history_disease_model.dart
import 'dart:convert';
import 'dart:typed_data';

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
  final Uint8List imageBytes;
  final int userId;

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
    required this.imageBytes,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'disease_id': diseaseId, // تم تغيير المفتاح من id إلى disease_id
      'name': name,
      'origin_name': originName,
      'scientific_name': scientificName,
      'also_know_as': alsoKnowAs,
      'type_disease': typeDisease,
      'description': description,
      'symptoms': jsonEncode(symptoms.map((e) => e.toJson()).toList()),
      'solutions': jsonEncode(solutions.map((e) => e.toJson()).toList()),
      'preventions': jsonEncode(preventions.map((e) => e.toJson()).toList()),
      'home_remedys': jsonEncode(homeRemedys.map((e) => e.toJson()).toList()),
      'disease_images':
          jsonEncode(diseaseImages.map((e) => e.toJson()).toList()),
      'image_bytes': imageBytes,
      'user_id': userId,
    };
  }

  factory HistoryDisease.fromMap(Map<String, dynamic> map) {
    return HistoryDisease(
      diseaseId: map['disease_id'], // قراءة المفتاح disease_id
      name: map['name'],
      originName: map['origin_name'],
      scientificName: map['scientific_name'],
      alsoKnowAs: map['also_know_as'],
      typeDisease: map['type_disease'],
      description: map['description'],
      symptoms: List<Symptom>.from(
        jsonDecode(map['symptoms']).map((x) => Symptom.fromJson(x)),
      ),
      solutions: List<Solution>.from(
        jsonDecode(map['solutions']).map((x) => Solution.fromJson(x)),
      ),
      preventions: List<Prevention>.from(
        jsonDecode(map['preventions']).map((x) => Prevention.fromJson(x)),
      ),
      homeRemedys: List<HomeRemedy>.from(
        jsonDecode(map['home_remedys']).map((x) => HomeRemedy.fromJson(x)),
      ),
      diseaseImages: List<DiseaseImage>.from(
        jsonDecode(map['disease_images']).map((x) => DiseaseImage.fromJson(x)),
      ),
      imageBytes: map['image_bytes'],
      userId: map['user_id'],
    );
  }
}
