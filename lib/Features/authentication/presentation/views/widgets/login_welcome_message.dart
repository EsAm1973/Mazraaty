import 'package:flutter/material.dart';
import 'package:mazraaty/Core/utils/styles.dart';
import 'package:mazraaty/constants.dart';

class LoginWelcomeMessage extends StatelessWidget {
  const LoginWelcomeMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Welcome Back',
          style: Styles.textStyle34.copyWith(fontFamily: kfontFamily),
        ),
        const SizedBox(height: 10),
        Text(
          'Login to your account',
          style: Styles.textStyle18.copyWith(
            color: const Color(0xff939393),
          ),
        ),
      ],
    );
  }
}
