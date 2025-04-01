class PointsModel {
  final int points;

  PointsModel({required this.points});

  factory PointsModel.fromJson(Map<String, dynamic> json) {
    return PointsModel(
      points: json['data'] ?? 0,
    );
  }
} 