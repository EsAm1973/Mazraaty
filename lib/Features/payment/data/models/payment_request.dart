class PaymentRequestModel {
  final int packageId;
  final double price;

  PaymentRequestModel({required this.packageId, required this.price});

  Map<String, dynamic> toJson() {
    return {
      'package_id': packageId,
      'price': price,
    };
  }
}
