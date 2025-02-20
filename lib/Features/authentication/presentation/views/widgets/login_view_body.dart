import 'package:flutter/material.dart';
import 'package:mazraaty/Core/utils/styles.dart';
import 'package:mazraaty/Features/authentication/presentation/views/widgets/login_button.dart';
import 'package:mazraaty/Features/authentication/presentation/views/widgets/login_forgetpass.dart';
import 'package:mazraaty/Features/authentication/presentation/views/widgets/login_name_textfeild.dart';
import 'package:mazraaty/Features/authentication/presentation/views/widgets/login_or_signwith.dart';
import 'package:mazraaty/Features/authentication/presentation/views/widgets/login_password_textfeild.dart';
import 'package:mazraaty/Features/authentication/presentation/views/widgets/login_top_image.dart';
import 'package:mazraaty/Features/authentication/presentation/views/widgets/login_welcome_message.dart';

class LoginViewBody extends StatelessWidget {
  LoginViewBody({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const LoginTopImage(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: formKey,
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
                  const SizedBox(height: 30),
                  LoginButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        // Navigate to main screen
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Login successful!'),
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const OrSignWithWidget(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

