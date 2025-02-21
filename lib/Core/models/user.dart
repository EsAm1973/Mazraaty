class User {
  final int id;
  final String username;
  final String email;
  final String phone;
  final String token;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.phone,
    required this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      username: json['user_name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone_number'] ?? '',
      token: json['token'] ?? '',
    );
  }
}
