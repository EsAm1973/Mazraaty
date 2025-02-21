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
