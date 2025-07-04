import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mazraaty/Core/utils/app_router.dart';
import 'package:mazraaty/Core/widgets/dialog_helper.dart';
import 'package:mazraaty/Features/authentication/presentation/manager/Authentication/authentication_cubit.dart';
import 'package:mazraaty/Features/authentication/presentation/views/widgets/login_top_image.dart';
import 'package:mazraaty/Features/authentication/presentation/views/widgets/signup_button.dart';
import 'package:mazraaty/Features/authentication/presentation/views/widgets/signup_confirmpass.dart';
import 'package:mazraaty/Features/authentication/presentation/views/widgets/signup_email_textfeild.dart';
import 'package:mazraaty/Features/authentication/presentation/views/widgets/signup_move_to_login.dart';
import 'package:mazraaty/Features/authentication/presentation/views/widgets/signup_username_textfeild.dart';
import 'package:mazraaty/Features/authentication/presentation/views/widgets/signup_password_textfeild.dart';
import 'package:mazraaty/Features/authentication/presentation/views/widgets/signup_phone_textfeild.dart';
import 'package:mazraaty/Features/authentication/presentation/views/widgets/signup_welcome_message.dart';

class SignupViewBody extends StatelessWidget {
  SignupViewBody({super.key});
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is RegisterAuthLoading) {
          DialogHelper.showLoading(context);
        } else if (state is RegisterAuthSuccess) {
          DialogHelper.hideLoading();
          DialogHelper.showSuccess(
            context,
            'Registration Successful!',
            'Check your email for verification link',
            () => GoRouter.of(context).pushReplacement(AppRouter.kLoginView),
          );
        } else if (state is RegisterAuthError) {
          DialogHelper.hideLoading();
          DialogHelper.showError(
            context,
            'Registration Failed',
            state.errorMessage,
          );
        }
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            const LoginTopImage(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    const SignUpWelcomeMessage(),
                    const SizedBox(height: 20),
                    SignUpUserNameTextFeild(nameController: userNameController),
                    const SizedBox(height: 20),
                    SignUpEmailTextFeild(emailController: emailController),
                    const SizedBox(height: 20),
                    SignUpPhoneTextFeild(phoneController: phoneController),
                    const SizedBox(height: 20),
                    SignUpPasswordTextFeild(
                        passwordController: passwordController),
                    const SizedBox(height: 20),
                    SignUpConfirmPassword(
                      passwordController: passwordController,
                      confirmPasswordController: confirmPasswordController,
                    ),
                    const SizedBox(height: 20),
                    BlocBuilder<AuthenticationCubit, AuthenticationState>(
                      builder: (context, state) {
                        return SignUpButton(onPressed: () {
                          if (formKey.currentState!.validate()) {
                            context.read<AuthenticationCubit>().register(
                                  username: userNameController.text,
                                  phone: phoneController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                          }
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    const SignUpMoveToLogin(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
