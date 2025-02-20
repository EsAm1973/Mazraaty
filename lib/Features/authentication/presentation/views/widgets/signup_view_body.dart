import 'package:flutter/material.dart';
import 'package:mazraaty/Features/authentication/presentation/views/widgets/login_top_image.dart';
import 'package:mazraaty/Features/authentication/presentation/views/widgets/signup_confirmpass.dart';
import 'package:mazraaty/Features/authentication/presentation/views/widgets/signup_email_textfeild.dart';
import 'package:mazraaty/Features/authentication/presentation/views/widgets/signup_name_textfeild.dart';
import 'package:mazraaty/Features/authentication/presentation/views/widgets/signup_password_textfeild.dart';
import 'package:mazraaty/Features/authentication/presentation/views/widgets/signup_phone_textfeild.dart';
import 'package:mazraaty/Features/authentication/presentation/views/widgets/signup_welcome_message.dart';

class SignupViewBody extends StatelessWidget {
  SignupViewBody({super.key});
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
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
                const SizedBox(height: 20),
                SignUpNameTextFeild(nameController: nameController),
                const SizedBox(height: 20),
                SignUpEmailTextFeild(emailController: emailController),
                const SizedBox(height: 20),
                SignUpPhoneTextFeild(phoneController: phoneController),
                const SizedBox(height: 20),
                SignUpPasswordTextFeild(passwordController: passwordController),
                const SizedBox(height: 20),
                SignUpConfirmPassword(
                  passwordController: passwordController,
                  confirmPasswordController: confirmPasswordController,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
