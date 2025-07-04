import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mazraaty/Core/data/Cubits/Change%20Pass%20Cubit/change_password_cubit.dart';
import 'package:mazraaty/Core/utils/app_router.dart';
import 'package:mazraaty/Core/utils/styles.dart';
import 'package:mazraaty/Core/widgets/dialog_helper.dart';
import 'package:mazraaty/Features/authentication/presentation/views/widgets/verifycode_backbutton.dart';
import 'package:mazraaty/Features/authentication/presentation/views/widgets/verifycode_otpbox.dart';
import 'package:mazraaty/Features/authentication/presentation/views/widgets/verifycode_title.dart';

class VerifyCodeViewBody extends StatefulWidget {
  const VerifyCodeViewBody({super.key, required this.email});
  final String email;

  @override
  State<VerifyCodeViewBody> createState() => _VerifyCodeViewBodyState();
}

class _VerifyCodeViewBodyState extends State<VerifyCodeViewBody> {
  // Controllers for each OTP digit
  final TextEditingController _digit1Controller = TextEditingController();
  final TextEditingController _digit2Controller = TextEditingController();
  final TextEditingController _digit3Controller = TextEditingController();
  final TextEditingController _digit4Controller = TextEditingController();

  // Focus nodes for each field
  final FocusNode _digit1Focus = FocusNode();
  final FocusNode _digit2Focus = FocusNode();
  final FocusNode _digit3Focus = FocusNode();
  final FocusNode _digit4Focus = FocusNode();

  Timer? _timer;
  int _secondsRemaining = 60;
  bool get _canResend => _secondsRemaining == 0;

  @override
  void initState() {
    super.initState();
    _startCounting();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _digit1Controller.dispose();
    _digit2Controller.dispose();
    _digit3Controller.dispose();
    _digit4Controller.dispose();
    _digit1Focus.dispose();
    _digit2Focus.dispose();
    _digit3Focus.dispose();
    _digit4Focus.dispose();
    super.dispose();
  }

  void _startCounting() {
    _timer?.cancel();
    setState(() => _secondsRemaining = 60);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() => _secondsRemaining--);
      } else {
        timer.cancel();
      }
    });
  }

  String get _formattedTime {
    final m = (_secondsRemaining ~/ 60).toString().padLeft(2, '0');
    final s = (_secondsRemaining % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  void _onResendPressed() {
    context.read<PasswordCubit>().sendOtp(widget.email);
  }

  void _verifyOtp() {
    final otp = _digit1Controller.text +
        _digit2Controller.text +
        _digit3Controller.text +
        _digit4Controller.text;
    context.read<PasswordCubit>().verifyOtp(widget.email, otp);
  }

  bool _allFieldsFilled() {
    return _digit1Controller.text.length == 1 &&
        _digit2Controller.text.length == 1 &&
        _digit3Controller.text.length == 1 &&
        _digit4Controller.text.length == 1;
  }

  void _onFieldChanged(String _) {
    if (_allFieldsFilled()) {
      _verifyOtp();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PasswordCubit, ChangePasswordState>(
      listener: (context, state) {
        // Resend-code states
        if (state is ForgotPasswordLoading) {
          DialogHelper.showLoading(context);
        } else if (state is ForgotPasswordSuccess) {
          DialogHelper.hideLoading();
          DialogHelper.showSuccess(
            context,
            'Verification Sent!',
            'A new code has been sent to your email.',
            () {
              // close success dialog
              _startCounting(); // start countdown
            },
          );
        } else if (state is ForgotPasswordError) {
          DialogHelper.hideLoading();
          DialogHelper.showError(
            context,
            'Sending Failed',
            state.errorMessage,
          );
        }

        // Verify-OTP states
        if (state is VerifyOtpSuccess) {
          GoRouter.of(context).push(
            AppRouter.kResetPassView,
            extra: {'email': widget.email, 'token': state.token},
          );
        } else if (state is VerifyOtpError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage)),
          );
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                VerifyCodeBackButton(onPressed: () {
                  GoRouter.of(context).pop();
                }),
                const SizedBox(height: 110),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    children: [
                      const VerifyCodeTitle(),
                      const SizedBox(height: 33),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          VerifyCodeOtpBox(
                            controller: _digit1Controller,
                            focusNode: _digit1Focus,
                            nextFocusNode: _digit2Focus,
                            onChanged: _onFieldChanged,
                          ),
                          VerifyCodeOtpBox(
                            controller: _digit2Controller,
                            focusNode: _digit2Focus,
                            nextFocusNode: _digit3Focus,
                            onChanged: _onFieldChanged,
                          ),
                          VerifyCodeOtpBox(
                            controller: _digit3Controller,
                            focusNode: _digit3Focus,
                            nextFocusNode: _digit4Focus,
                            onChanged: _onFieldChanged,
                          ),
                          VerifyCodeOtpBox(
                            controller: _digit4Controller,
                            focusNode: _digit4Focus,
                            isLast: true,
                            onChanged: _onFieldChanged,
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      Column(
                        children: [
                          Text(
                            'Didn\'t receive OTP?',
                            style:
                                Styles.textStyle15.copyWith(color: Colors.grey),
                          ),
                          const SizedBox(height: 4),
                          _canResend
                              ? TextButton(
                                  onPressed: _onResendPressed,
                                  child: Text(
                                    'Resend code',
                                    style: Styles.textStyle15.copyWith(
                                      fontWeight: FontWeight.w600,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                )
                              : Text(
                                  'You can resend in $_formattedTime',
                                  style: Styles.textStyle15
                                      .copyWith(color: Colors.grey),
                                ),
                        ],
                      ),
                      if (state is VerifyOtpLoading) ...[
                        const SizedBox(height: 16),
                        const CircularProgressIndicator(),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
