import 'package:dartz/dartz.dart';
import 'package:mazraaty/Core/errors/failure.dart';
import 'package:mazraaty/Features/payment/data/models/payment_request.dart';
import 'package:mazraaty/Features/payment/data/models/payment_response.dart';

abstract class IPaymentRepository {
  Future<Either<Failure, PaymentResponseModel>> initiatePaypalPayment(
      PaymentRequestModel paymentRequest,
      {String? token,
      required String currency});
      
  Future<Either<Failure, PaymentResponseModel>> initiateMyfatoorahPayment(
      PaymentRequestModel paymentRequest,
      {String? token,
      required String currency});
}
