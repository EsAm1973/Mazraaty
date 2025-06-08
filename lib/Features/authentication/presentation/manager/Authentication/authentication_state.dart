part of 'authentication_cubit.dart';

@immutable
sealed class AuthenticationState {}

final class AuthenticationInitial extends AuthenticationState {}

final class LoginAuthLoading extends AuthenticationState {}

final class LoginAuthSuccess extends AuthenticationState {
  final User user;

  LoginAuthSuccess({required this.user});
}

final class LoginAuthError extends AuthenticationState {
  final String errorMessage;

  LoginAuthError({required this.errorMessage});
}

final class RegisterAuthLoading extends AuthenticationState {}

final class RegisterAuthSuccess extends AuthenticationState {
  final User user;

  RegisterAuthSuccess({required this.user});
}

final class RegisterAuthError extends AuthenticationState {
  final String errorMessage;

  RegisterAuthError({required this.errorMessage});
}

// Google Sign-In States
final class GoogleSignInLoading extends AuthenticationState {}

final class GoogleSignInSuccess extends AuthenticationState {
  final User user;

  GoogleSignInSuccess({required this.user});
}

final class GoogleSignInError extends AuthenticationState {
  final String errorMessage;

  GoogleSignInError({required this.errorMessage});
}

/// ====================== ///
/// Forgot Password States ///
/// ====================== ///
final class ForgotPasswordLoading extends AuthenticationState {}

final class ForgotPasswordSuccess extends AuthenticationState {
  final String email;
  ForgotPasswordSuccess({required this.email});
}

final class ForgotPasswordError extends AuthenticationState {
  final String errorMessage;
  ForgotPasswordError({required this.errorMessage});
}

// Verify OTP States
final class VerifyOtpLoading extends AuthenticationState {}

final class VerifyOtpSuccess extends AuthenticationState {
  final String token;
  VerifyOtpSuccess({required this.token});
}

final class VerifyOtpError extends AuthenticationState {
  final String errorMessage;
  VerifyOtpError({required this.errorMessage});
}

// Reset Password States
final class ResetPasswordLoading extends AuthenticationState {}

final class ResetPasswordSuccess extends AuthenticationState {}

final class ResetPasswordError extends AuthenticationState {
  final String errorMessage;
  ResetPasswordError({required this.errorMessage});
}
