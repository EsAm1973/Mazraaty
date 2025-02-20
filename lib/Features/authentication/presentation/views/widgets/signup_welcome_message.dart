import 'package:flutter/material.dart';
import 'package:mazraaty/Core/utils/styles.dart';
import 'package:mazraaty/constants.dart';

class SignUpWelcomeMessage extends StatelessWidget {
  const SignUpWelcomeMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Register',
          style: Styles.textStyle34.copyWith(fontFamily: kfontFamily),
        ),
        const SizedBox(height: 10),
        Text(
          'Create your new account',
          style: Styles.textStyle18.copyWith(
            color: const Color(0xff939393),
          ),
        ),
      ],
    );
  }
}
