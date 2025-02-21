import 'package:bloc/bloc.dart';
import 'package:mazraaty/Core/models/user.dart';
import 'package:mazraaty/Features/authentication/data/repos/authentication_repo.dart';
import 'package:meta/meta.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit(this.authenticationRepo) : super(AuthenticationInitial());
  final AuthenticationRepo authenticationRepo;

  Future<void> login({required String email, required String password}) async {
    emit(LoginAuthLoading());
    final result =
        await authenticationRepo.login(email: email, password: password);
    result.fold((l) => {emit(LoginAuthError(errorMessage: l.errorMessage))},
        (r) => {emit(LoginAuthSuccess(user: User.fromJson(r)))});
  }

  Future<void> register({
    required String username,
    required String phone,
    required String email,
    required String password,
  }) async {
    emit(RegisterAuthLoading());
    final result = await authenticationRepo.register(
      username: username,
      phone: phone,
      email: email,
      password: password,
    );
    result.fold(
        (failure) =>
            emit(RegisterAuthError(errorMessage: failure.errorMessage)),
        (user) {
      emit(RegisterAuthSuccess(user: User.fromJson(user)));
    });
  }
}
