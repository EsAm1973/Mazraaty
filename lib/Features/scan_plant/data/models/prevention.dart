class Prevention {
  final String title;
  final String description;

  Prevention({
    required this.title,
    required this.description,
  });

  factory Prevention.fromJson(Map<String, dynamic> json) {
    return Prevention(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
    );
  }
  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
      };
}
