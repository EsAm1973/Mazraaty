class DiseaseImage {
  final String image;

  DiseaseImage({required this.image});

  factory DiseaseImage.fromJson(Map<String, dynamic> json) {
    return DiseaseImage(
      image: json['image'] ?? '',
    );
  }
}
