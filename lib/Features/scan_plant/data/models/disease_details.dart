import 'package:mazraaty/Features/scan_plant/data/models/disease_image.dart';
import 'package:mazraaty/Features/scan_plant/data/models/home_remedy.dart';
import 'package:mazraaty/Features/scan_plant/data/models/prevention.dart';
import 'package:mazraaty/Features/scan_plant/data/models/soluation.dart';
import 'package:mazraaty/Features/scan_plant/data/models/symptom.dart';

class DiseaseDetailsModel {
  final int id;
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

  DiseaseDetailsModel({
    required this.id,
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
  });

  factory DiseaseDetailsModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return DiseaseDetailsModel(
      id: data['id'] ?? 0,
      name: data['name'] ?? '',
      originName: data['origin_name'] ?? '',
      scientificName: data['scientific_name'] ?? '',
      alsoKnowAs: data['also_know_as'] ?? '',
      typeDisease: data['type_disease'] ?? '',
      description: data['description'] ?? '',
      symptoms: (data['symptoms'] as List<dynamic>? ?? [])
          .map((e) => Symptom.fromJson(e))
          .toList(),
      solutions: (data['solutions'] as List<dynamic>? ?? [])
          .map((e) => Solution.fromJson(e))
          .toList(),
      preventions: (data['preventions'] as List<dynamic>? ?? [])
          .map((e) => Prevention.fromJson(e))
          .toList(),
      homeRemedys: (data['homeRemedys'] as List<dynamic>? ?? [])
          .map((e) => HomeRemedy.fromJson(e))
          .toList(),
      diseaseImages: (data['disease_images'] as List<dynamic>? ?? [])
          .map((e) => DiseaseImage.fromJson(e))
          .toList(),
    );
  }
}
