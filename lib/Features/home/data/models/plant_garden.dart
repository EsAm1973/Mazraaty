class PlantGarden {
  final String name;
  final String imageUrl;
  final String status;
  final String lastWatered;
  final String? plantType;
  final String? age;
  final DateTime? nextWateringDate;
  final String? careDifficulty;
  final String? growthStage;
  final double? waterLevel;
  final double? sunlightLevel;
  final String? location;
  final List<CareHistory>? careHistory;
  final List<String>? tags;

  PlantGarden({
    required this.name,
    required this.imageUrl,
    required this.status,
    required this.lastWatered,
    this.plantType,
    this.age,
    this.nextWateringDate,
    this.careDifficulty,
    this.growthStage,
    this.waterLevel,
    this.sunlightLevel,
    this.location,
    this.careHistory,
    this.tags,
  });

  // Create a copy of this plant with modified attributes
  PlantGarden copyWith({
    String? name,
    String? imageUrl,
    String? status,
    String? lastWatered,
    String? plantType,
    String? age,
    DateTime? nextWateringDate,
    String? careDifficulty,
    String? growthStage,
    double? waterLevel,
    double? sunlightLevel,
    String? location,
    List<CareHistory>? careHistory,
    List<String>? tags,
  }) {
    return PlantGarden(
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      status: status ?? this.status,
      lastWatered: lastWatered ?? this.lastWatered,
      plantType: plantType ?? this.plantType,
      age: age ?? this.age,
      nextWateringDate: nextWateringDate ?? this.nextWateringDate,
      careDifficulty: careDifficulty ?? this.careDifficulty,
      growthStage: growthStage ?? this.growthStage,
      waterLevel: waterLevel ?? this.waterLevel,
      sunlightLevel: sunlightLevel ?? this.sunlightLevel,
      location: location ?? this.location,
      careHistory: careHistory ?? this.careHistory,
      tags: tags ?? this.tags,
    );
  }
}

class CareHistory {
  final DateTime date;
  final String action;
  final String? notes;

  CareHistory({
    required this.date,
    required this.action,
    this.notes,
  });
}
