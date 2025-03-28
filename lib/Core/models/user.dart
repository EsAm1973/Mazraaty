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

  User copyWith({
    int? id,
    String? username,
    String? email,
    String? phone,
    int? points,
    String? token,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      points: points ?? this.points,
      token: token ?? this.token,
    );
  }
}
