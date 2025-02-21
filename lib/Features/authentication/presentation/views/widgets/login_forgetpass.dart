import 'package:flutter/material.dart';
import 'package:mazraaty/Core/utils/styles.dart';
import 'package:mazraaty/constants.dart';

class LoginForgetPassword extends StatelessWidget {
  const LoginForgetPassword({super.key, required this.onPressed});
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          'Forget Password ?',
          style: Styles.textStyle16.copyWith(
              color: kMainColor, decoration: TextDecoration.underline),
        ),
      ),
    );
  }
}
