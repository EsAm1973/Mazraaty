import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mazraaty/Core/data/Cubits/User%20Cubit/user_cubit.dart';
import 'package:mazraaty/Features/payment/data/models/payment_request.dart';
import 'package:mazraaty/Features/payment/data/models/payment_response.dart';
import 'package:mazraaty/Features/payment/data/repos/Payment%20Repo/payment_repo.dart';
import 'package:mazraaty/Features/payment/presentation/manager/Package%20Cubit/cubit/packages_cubit.dart';
import 'package:url_launcher/url_launcher.dart';
part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  final IPaymentRepository paymentRepository;
  final UserCubit userCubit;
  final PackagesCubit packagesCubit;

  PaymentCubit({
    required this.paymentRepository,
    required this.userCubit,
    required this.packagesCubit,
  }) : super(PaymentInitial());

  Future<void> initiatePaypalPayment({
    required int packageId,
    required double price,
    String? currency,
  }) async {
    emit(PaymentLoading());

    // Create payment request model with packageId and price
    final paymentRequest = PaymentRequestModel(
      packageId: packageId,
      price: price,
    );

    // Get auth token from UserCubit
    final token = userCubit.currentUser?.token;

    if (token == null) {
      emit(const PaymentFailure(errorMessage: 'Authentication required'));
      return;
    }

    // Get the currently selected currency from PackagesCubit or use provided currency
    final selectedCurrency = currency ?? packagesCubit.selectedCurrency;

    // Debug log to verify currency
    debugPrint('PaymentCubit: Using currency $selectedCurrency for payment');

    // Make payment request with token and selected currency
    final result = await paymentRepository.initiatePaypalPayment(
      paymentRequest,
      token: token,
      currency: selectedCurrency,
    );

    result.fold(
      (failure) => emit(PaymentFailure(errorMessage: failure.errorMessage)),
      (response) {
        emit(PaymentSuccess(paymentResponse: response));
        if (response.success) {
          _launchPaypalUrl(response.url);
        }
      },
    );
  }

  Future<void> _launchPaypalUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      emit(const PaymentFailure(errorMessage: 'Could not launch payment URL'));
    }
  }
}
