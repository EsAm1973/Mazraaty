class Package {
  final int id;
  final String name;
  final String description;
  final double price;
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
      price: _parsePrice(json['price']),
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
      'price': price.toString(),
      'conis': coins, // Using the same key as the API
      'badge': badge,
    };
  }

  // Helper method to safely parse price from various formats
  static double _parsePrice(dynamic priceValue) {
    if (priceValue is double) return priceValue;
    if (priceValue is int) return priceValue.toDouble();
    if (priceValue is String) {
      try {
        return double.parse(priceValue);
      } catch (e) {
        // Remove non-numeric characters except decimal point and try again
        final cleanedPrice = priceValue.replaceAll(RegExp(r'[^\d.]'), '');
        return double.parse(cleanedPrice);
      }
    }
    return 0.0; // Fallback value if parsing fails
  }
}
