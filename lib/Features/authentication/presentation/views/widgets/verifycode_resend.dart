import 'package:flutter/material.dart';
import 'package:mazraaty/Core/utils/styles.dart';

class VerifyCodeResendCode extends StatelessWidget {
  const VerifyCodeResendCode({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        'Didn\'t receive OTP ?',
        style: Styles.textStyle15.copyWith(color: Colors.grey),
      ),
      TextButton(
        onPressed: () {},
        child: Text(
          'Resend code',
          style: Styles.textStyle15.copyWith(
            fontWeight: FontWeight.w600,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    ]);
  }
}
