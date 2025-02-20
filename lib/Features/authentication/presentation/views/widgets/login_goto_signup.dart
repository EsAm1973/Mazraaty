import 'package:flutter/material.dart';
import 'package:mazraaty/Core/utils/styles.dart';
import 'package:mazraaty/constants.dart';

class LoginGoToSignUpScreen extends StatelessWidget {
  const LoginGoToSignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Don\'t have an account?',
          style: Styles.textStyle15,
        ),
        TextButton(
          child: Text(
            'Sign Up',
            style: Styles.textStyle15.copyWith(
              color: kMainColor,
              decoration: TextDecoration.underline,
            ),
          ),
          onPressed: () {
            //GoRouter.of(context).pushReplacement(AppRouter.kSignupView);
          },
        ),
      ],
    );
  }
}
