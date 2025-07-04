part of 'myfatoorah_cubit.dart';

abstract class MyFatoorahState extends Equatable {
  const MyFatoorahState();

  @override
  List<Object?> get props => [];
}

class MyFatoorahInitial extends MyFatoorahState {}

class MyFatoorahLoading extends MyFatoorahState {}

class MyFatoorahSuccess extends MyFatoorahState {
  final PaymentResponseModel paymentResponse;

  const MyFatoorahSuccess({required this.paymentResponse});

  @override
  List<Object?> get props => [paymentResponse];
}

class MyFatoorahFailure extends MyFatoorahState {
  final String errorMessage;

  const MyFatoorahFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
} 