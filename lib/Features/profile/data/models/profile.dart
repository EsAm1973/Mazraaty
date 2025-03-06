class Profile {
  final String userName;
  final String email;
  final String phoneNumber;
  final String image;
  final int points;

  Profile({
    required this.userName,
    required this.email,
    required this.phoneNumber,
    required this.image,
    required this.points,
  });

  // تحليل البيانات من JSON
  factory Profile.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return Profile(
      userName: data['user_name'] ?? '',
      email: data['email'] ?? '',
      phoneNumber: data['phone_number'] ?? '',
      image: data['image'] ?? '',
      points: data['points'] ?? 0,
    );
  }
}
