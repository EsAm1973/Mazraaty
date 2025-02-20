import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mazraaty/Core/utils/styles.dart';
import 'package:mazraaty/Core/widgets/custom_textfeild.dart';
import 'package:mazraaty/Features/authentication/presentation/views/widgets/login_top_image.dart';
import 'package:mazraaty/Features/authentication/presentation/views/widgets/signup_email_textfeild.dart';
import 'package:mazraaty/Features/authentication/presentation/views/widgets/signup_name_textfeild.dart';
import 'package:mazraaty/Features/authentication/presentation/views/widgets/signup_phone_textfeild.dart';
import 'package:mazraaty/Features/authentication/presentation/views/widgets/signup_welcome_message.dart';
import 'package:mazraaty/constants.dart';

class SignupViewBody extends StatelessWidget {
  SignupViewBody({super.key});
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}

