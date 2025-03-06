class User {
  final int id;
  final String username;
  final String email;
  final String phone;
  final int points;
  final String token;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.phone,
    required this.points,
    required this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      username: json['user_name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone_number'] ?? '',
      points: json['points'] ?? 0,
      token: json['token'] ?? '',
    );
  }
}
