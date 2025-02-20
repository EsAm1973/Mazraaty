import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mazraaty/Core/utils/app_router.dart';
import 'package:mazraaty/Core/utils/styles.dart';
import 'package:mazraaty/constants.dart';

class SignUpMoveToLogin extends StatelessWidget {
  const SignUpMoveToLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already have an account?',
          style: Styles.textStyle15.copyWith(
            color: const Color(0xff939393),
          ),
        ),
        TextButton(
          child: Text('Login',
              style: Styles.textStyle15.copyWith(
                  color: kMainColor, decoration: TextDecoration.underline)),
          onPressed: () {
            GoRouter.of(context).pushReplacement(AppRouter.kLoginView);
          },
        ),
      ],
    );
  }
}
