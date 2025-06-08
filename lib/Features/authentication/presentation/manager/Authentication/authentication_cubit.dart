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

  Future<void> signInWithGoogle() async {
    emit(GoogleSignInLoading());
    final result = await authenticationRepo.signInWithGoogle();
    result.fold(
      (failure) => emit(GoogleSignInError(errorMessage: failure.errorMessage)),
      (userData) => emit(GoogleSignInSuccess(user: User.fromJson(userData))),
    );
  }

  /// =============== ///
  /// Forget Password ///
  /// =============== ///
  // Future<void> sendOtp(String email) async {
  //   emit(ForgotPasswordLoading());
  //   final result = await authenticationRepo.sendOtp(email);
  //   result.fold(
  //     (failure) =>
  //         emit(ForgotPasswordError(errorMessage: failure.errorMessage)),
  //     (response) => emit(ForgotPasswordSuccess(email: email)),
  //   );
  // }

  // Future<void> verifyOtp(String email, String otp) async {
  //   emit(VerifyOtpLoading());
  //   final result = await authenticationRepo.verifyOtp(email, otp);
  //   result.fold(
  //     (failure) => emit(VerifyOtpError(errorMessage: failure.errorMessage)),
  //     (response) {
  //       final token =
  //           response['data']['token']; // Adjust based on your API response
  //       emit(VerifyOtpSuccess(token: token));
  //     },
  //   );
  // }

  // Future<void> resetPassword(
  //     String email, String otp, String newPassword) async {
  //   emit(ResetPasswordLoading());
  //   final result =
  //       await authenticationRepo.resetPassword(email, otp, newPassword);
  //   result.fold(
  //     (failure) => emit(ResetPasswordError(errorMessage: failure.errorMessage)),
  //     (response) => emit(ResetPasswordSuccess()),
  //   );
  // }

}
