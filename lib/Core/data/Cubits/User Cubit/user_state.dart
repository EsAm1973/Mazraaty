part of 'user_cubit.dart';

@immutable
abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

final class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final User user;
  const UserLoaded(this.user);

  @override
  List<Object> get props => [user]; // قارن تغييرات User
}

class UserError extends UserState {
  final String message;
  const UserError(this.message);
}
