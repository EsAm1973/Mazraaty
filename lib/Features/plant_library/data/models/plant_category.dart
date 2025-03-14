import 'package:mazraaty/Features/plant_library/data/models/plant.dart';

class PlantCategory {
  final int id;
  final String name;
  final List<Plant> plants;

  PlantCategory({
    required this.id,
    required this.name,
    required this.plants,
  });

  factory PlantCategory.fromJson(Map<String, dynamic> json) {
    return PlantCategory(
      id: json['id'],
      name: json['name'],
      plants: (json['plants'] as List)
          .map((plantJson) => Plant.fromJson(plantJson))
          .toList(),
    );
  }
}
