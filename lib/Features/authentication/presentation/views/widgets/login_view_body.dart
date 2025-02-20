import 'package:flutter/material.dart';
import 'package:mazraaty/Features/authentication/presentation/views/widgets/login_forgetpass.dart';
import 'package:mazraaty/Features/authentication/presentation/views/widgets/login_name_textfeild.dart';
import 'package:mazraaty/Features/authentication/presentation/views/widgets/login_password_textfeild.dart';
import 'package:mazraaty/Features/authentication/presentation/views/widgets/login_top_image.dart';
import 'package:mazraaty/Features/authentication/presentation/views/widgets/login_welcome_message.dart';

class LoginViewBody extends StatelessWidget {
  LoginViewBody({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const LoginTopImage(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const LoginWelcomeMessage(),
              const SizedBox(height: 20),
              LoginEmailTextFeild(
                emailController: emailController,
              ),
              const SizedBox(height: 20),
              LoginPasswordTextFeild(
                passwordController: passwordController,
              ),
              const LoginForgetPassword(),
            ],
          ),
        ),
      ],
    );
  }
}

