import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mazraaty/Core/errors/failure.dart';
import 'package:mazraaty/Core/utils/api_service.dart';
import 'package:mazraaty/Features/payment/data/models/payment_request.dart';
import 'package:mazraaty/Features/payment/data/models/payment_response.dart';
import 'package:mazraaty/Features/payment/data/repos/Payment%20Repo/payment_repo.dart';

class PaymentRepositoryImpl implements IPaymentRepository {
  final ApiService apiService;

  PaymentRepositoryImpl({required this.apiService});

  @override
  Future<Either<Failure, PaymentResponseModel>> initiatePaypalPayment(
      PaymentRequestModel paymentRequest,
      {String? token,
      required String currency}) async {
    try {
      // Prepare headers
      Map<String, dynamic> headers = {
        'Accept': 'application/json',
        'Currency': currency,
      };

      // Debug log the headers
      debugPrint('PaymentRepositoryImpl: Headers for payment request:');
      debugPrint('Currency: $currency');
      debugPrint(
          'Authorization: ${token != null ? 'Bearer token provided' : 'No token'}');

      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }

      final response = await apiService.post(
        'payment/process',
        paymentRequest.toJson(),
        headers: headers,
      );

      final paymentResponse = PaymentResponseModel.fromJson(response);
      return Right(paymentResponse);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, PaymentResponseModel>> initiateMyfatoorahPayment(
      PaymentRequestModel paymentRequest,
      {String? token,
      required String currency}) async {
    try {
      // Prepare headers
      Map<String, dynamic> headers = {
        'Accept': 'application/json',
        'Currency': currency,
        'PaymentMethod': 'myfatoorah',
      };

      // Debug log the headers
      debugPrint('PaymentRepositoryImpl: Headers for My Fatoorah payment request:');
      debugPrint('Currency: $currency');
      debugPrint(
          'Authorization: ${token != null ? 'Bearer token provided' : 'No token'}');

      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }

      final response = await apiService.post(
        'myfatoorah/payment/process',
        paymentRequest.toJson(),
        headers: headers,
      );

      final paymentResponse = PaymentResponseModel.fromJson(response);
      return Right(paymentResponse);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }
}
