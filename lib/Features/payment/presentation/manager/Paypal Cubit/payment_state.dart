part of 'payment_cubit.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object?> get props => [];
}

class PaymentInitial extends PaymentState {}

class PaymentLoading extends PaymentState {}

class PaymentSuccess extends PaymentState {
  final PaymentResponseModel paymentResponse;

  const PaymentSuccess({required this.paymentResponse});

  @override
  List<Object?> get props => [paymentResponse];
}

class PaymentFailure extends PaymentState {
  final String errorMessage;

  const PaymentFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
} 