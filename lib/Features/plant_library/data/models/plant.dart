class Plant {
  final int id;
  final String name;
  final String description;
  final String image;
  final String sunlightAmount;
  final String soil;
  final String wateringAmount;
  final String temperatureRange;
  final String nutrients;

  Plant({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.sunlightAmount,
    required this.soil,
    required this.wateringAmount,
    required this.temperatureRange,
    required this.nutrients,
  });

  factory Plant.fromJson(Map<String, dynamic> json) {
    return Plant(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
      sunlightAmount: json['sunlight_anmount'],
      soil: json['soil'],
      wateringAmount: json['watering_anmount'],
      temperatureRange: json['temperature_range'],
      nutrients: json['nutrients'],
    );
  }
}