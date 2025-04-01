class Package {
  final int id;
  final String name;
  final String description;
  final String price;
  final int coins;
  final String badge;

  Package({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.coins,
    required this.badge,
  });

  factory Package.fromJson(Map<String, dynamic> json) {
    return Package(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      price: json['price'] as String,
      // Note: There's a typo in the API response ("conis" instead of "coins")
      coins: json['conis'] as int,
      badge: json['badge'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'conis': coins, // Using the same key as the API
      'badge': badge,
    };
  }
} 