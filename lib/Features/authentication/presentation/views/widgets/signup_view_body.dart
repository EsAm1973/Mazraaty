import 'package:flutter/material.dart';
import 'package:mazraaty/Core/utils/styles.dart';
import 'package:mazraaty/Features/authentication/presentation/views/widgets/login_top_image.dart';
import 'package:mazraaty/Features/authentication/presentation/views/widgets/signup_welcome_message.dart';
import 'package:mazraaty/constants.dart';

class SignupViewBody extends StatelessWidget {
  const SignupViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const LoginTopImage(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SignUpWelcomeMessage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

