import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mazraaty/Features/authentication/data/repos/authentication_repo.dart';
part 'change_password_state.dart';

class PasswordCubit extends Cubit<ChangePasswordState> {
  final AuthenticationRepo authenticationRepo;

  PasswordCubit({required this.authenticationRepo}) : super(PasswordInitial());

  Future<void> sendOtp(String email) async {
    emit(ForgotPasswordLoading());
    final result = await authenticationRepo.sendOtp(email);
    result.fold(
      (failure) => emit(ForgotPasswordError(errorMessage: failure.errorMessage)),
      (response) => emit(ForgotPasswordSuccess(email: email)),
    );
  }

  Future<void> verifyOtp(String email, String otp) async {
    emit(VerifyOtpLoading());
    final result = await authenticationRepo.verifyOtp(email, otp);
    result.fold(
      (failure) => emit(VerifyOtpError(errorMessage: failure.errorMessage)),
      (response) {
        final token = response['data']['token']; // تأكد من تنسيق الاستجابة
        emit(VerifyOtpSuccess(token: token));
      },
    );
  }

  Future<void> resetPassword(String email, String otp, String newPassword) async {
    emit(ResetPasswordLoading());
    final result = await authenticationRepo.resetPassword(email, otp, newPassword);
    result.fold(
      (failure) => emit(ResetPasswordError(errorMessage: failure.errorMessage)),
      (response) => emit(ResetPasswordSuccess()),
    );
  }
}

