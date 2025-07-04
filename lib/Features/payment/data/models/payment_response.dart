class PaymentResponseModel {
  final bool success;
  final String url;

  PaymentResponseModel({required this.success, required this.url});

  factory PaymentResponseModel.fromJson(Map<String, dynamic> json) {
    return PaymentResponseModel(
      success: json['success'] as bool,
      url: json['url'] as String,
    );
  }
} 