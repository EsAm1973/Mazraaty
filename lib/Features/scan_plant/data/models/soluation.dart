class Solution {
  final String title;
  final String description;

  Solution({
    required this.title,
    required this.description,
  });

  factory Solution.fromJson(Map<String, dynamic> json) {
    return Solution(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
    );
  }
}