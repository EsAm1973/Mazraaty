
class PaymentRequestModel {
  final int packageId;

  PaymentRequestModel({required this.packageId});

  Map<String, dynamic> toJson() {
    return {
      'package_id': packageId,
    };
  }
} 