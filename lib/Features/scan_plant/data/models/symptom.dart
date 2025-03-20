class Symptom {
  final String title;
  final String description;

  Symptom({
    required this.title,
    required this.description,
  });

  factory Symptom.fromJson(Map<String, dynamic> json) {
    return Symptom(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
    );
  }
}