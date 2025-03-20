class HomeRemedy {
  final String title;
  final String description;

  HomeRemedy({
    required this.title,
    required this.description,
  });

  factory HomeRemedy.fromJson(Map<String, dynamic> json) {
    return HomeRemedy(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
    );
  }
}