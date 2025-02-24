class PredictionModel {
  final String disease;
  final double confidence;

  PredictionModel({
    required this.disease,
    required this.confidence,
  });

  factory PredictionModel.fromJson(Map<String, dynamic> json) {
    return PredictionModel(
      disease: json['disease'] ?? 'No prediction available',
      confidence: (json['confidence'] ?? 0.0).toDouble(),
    );
  }
}
