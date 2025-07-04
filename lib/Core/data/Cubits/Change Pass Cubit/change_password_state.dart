part of 'change_password_cubit.dart';

sealed class ChangePasswordState extends Equatable {
  const ChangePasswordState();

  @override
  List<Object> get props => [];
}

class PasswordInitial extends ChangePasswordState {}

class ForgotPasswordLoading extends ChangePasswordState {}

class ForgotPasswordSuccess extends ChangePasswordState {
  final String email;
  ForgotPasswordSuccess({required this.email});
}

class ForgotPasswordError extends ChangePasswordState {
  final String errorMessage;
  ForgotPasswordError({required this.errorMessage});
}

class VerifyOtpLoading extends ChangePasswordState {}

class VerifyOtpSuccess extends ChangePasswordState {
  final String token;
  VerifyOtpSuccess({required this.token});
}

class VerifyOtpError extends ChangePasswordState {
  final String errorMessage;
  VerifyOtpError({required this.errorMessage});
}

class ResetPasswordLoading extends ChangePasswordState {}

class ResetPasswordSuccess extends ChangePasswordState {}

class ResetPasswordError extends ChangePasswordState {
  final String errorMessage;
  ResetPasswordError({required this.errorMessage});
}

