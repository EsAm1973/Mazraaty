class Plant {
  final int id;
  final String name;
  final String botanicalName;
  final String scientificName;
  final String alsoKnownAs;
  final String description;
  final String genus;
  final String family;
  final String order;
  final String group;
  final String phylum;
  final String type;
  final String drainage;
  final String section;
  final String toughness;
  final String maintenance;
  final String sunlight;
  final String hardnessZone;
  final double minPh;
  final double maxPh;
  final double minTp;
  final double idealMinTp;
  final double idealMaxTp;
  final double maxTp;
  final String water;
  final String repotting;
  final String fertilizer;
  final String misting;
  final String pruning;
  final String uses;
  final String culture;
  final List<String> pests;
  final List<String> diseases;
  final List<String> tags;
  final String image;
  final String headerImage;

  Plant({
    required this.id,
    required this.name,
    required this.botanicalName,
    required this.scientificName,
    required this.alsoKnownAs,
    required this.description,
    required this.genus,
    required this.family,
    required this.order,
    required this.group,
    required this.phylum,
    required this.type,
    required this.drainage,
    required this.section,
    required this.toughness,
    required this.maintenance,
    required this.sunlight,
    required this.hardnessZone,
    required this.minPh,
    required this.maxPh,
    required this.minTp,
    required this.idealMinTp,
    required this.idealMaxTp,
    required this.maxTp,
    required this.water,
    required this.repotting,
    required this.fertilizer,
    required this.misting,
    required this.pruning,
    required this.uses,
    required this.culture,
    required this.pests,
    required this.diseases,
    required this.tags,
    required this.image,
    required this.headerImage,
  });

  // دالة مساعدة لتحويل القيمة إلى double
  static double _toDouble(dynamic value) {
    if (value is String) {
      return double.tryParse(value) ?? 0.0;
    } else if (value is num) {
      return value.toDouble();
    }
    return 0.0;
  }

  factory Plant.fromJson(Map<String, dynamic> json) {
    return Plant(
      id: json['id'],
      name: json['name'],
      botanicalName: json['botanical_name'] ?? '',
      scientificName: json['scientific_name'] ?? '',
      alsoKnownAs: json['also_known_as'] ?? '',
      description: json['description'] ?? '',
      genus: json['genus'] ?? '',
      family: json['family'] ?? '',
      order: json['order'] ?? '',
      group: json['group'] ?? '',
      phylum: json['phylum'] ?? '',
      type: json['type'] ?? '',
      drainage: json['drainage'] ?? '',
      section: json['section'] ?? '',
      toughness: json['toughness'] ?? '',
      maintenance: json['maintenance'] ?? '',
      sunlight: json['sunlight'] ?? '',
      hardnessZone: json['hardness_zone'] ?? '',
      minPh: _toDouble(json['min_ph']),
      maxPh: _toDouble(json['max_ph']),
      minTp: _toDouble(json['min_tp']),
      idealMinTp: _toDouble(json['ideal_min_tp']),
      idealMaxTp: _toDouble(json['ideal_max_tp']),
      maxTp: _toDouble(json['max_tp']),
      water: json['water'] ?? '',
      repotting: json['repotting'] ?? '',
      fertilizer: json['fertilizer'] ?? '',
      misting: json['misting'] ?? '',
      pruning: json['pruning'] ?? '',
      uses: json['uses'] ?? '',
      culture: json['cluture'] ?? '',
      pests: List<String>.from(json['pests'] ?? []),
      diseases: List<String>.from(json['diseases'] ?? []),
      tags: List<String>.from(json['tags'] ?? []),
      image: json['images']?['image'] ?? '',
      headerImage: json['images']?['header_image'] ?? '',
    );
  }
}
