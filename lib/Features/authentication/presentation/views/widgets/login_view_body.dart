import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mazraaty/Core/utils/app_router.dart';
import 'package:mazraaty/Features/authentication/presentation/manager/Authentication/authentication_cubit.dart';
import 'package:mazraaty/Features/authentication/presentation/views/widgets/login_button.dart';
import 'package:mazraaty/Features/authentication/presentation/views/widgets/login_email_textfeild.dart';
import 'package:mazraaty/Features/authentication/presentation/views/widgets/login_forgetpass.dart';
import 'package:mazraaty/Features/authentication/presentation/views/widgets/login_goto_signup.dart';
import 'package:mazraaty/Features/authentication/presentation/views/widgets/login_or_signwith.dart';
import 'package:mazraaty/Features/authentication/presentation/views/widgets/login_password_textfeild.dart';
import 'package:mazraaty/Features/authentication/presentation/views/widgets/login_socialmedia.dart';
import 'package:mazraaty/Features/authentication/presentation/views/widgets/login_top_image.dart';
import 'package:mazraaty/Features/authentication/presentation/views/widgets/login_welcome_message.dart';

class LoginViewBody extends StatelessWidget {
  LoginViewBody({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is LoginAuthSuccess) {
          // context.read<UserCubit>().saveUser(state.user);
          GoRouter.of(context).pushReplacement(AppRouter.kHomeView);
        } else if (state is LoginAuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage)),
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
                    const LoginWelcomeMessage(),
                    const SizedBox(height: 20),
                    LoginEmailTextFeild(
                      emailController: emailController,
                    ),
                    const SizedBox(height: 20),
                    LoginPasswordTextFeild(
                      passwordController: passwordController,
                    ),
                    LoginForgetPassword(
                      onPressed: () {
                        GoRouter.of(context).push(AppRouter.kRecoverPassView);
                      },
                    ),
                    const SizedBox(height: 30),
                    BlocBuilder<AuthenticationCubit, AuthenticationState>(
                      builder: (context, state) {
                        if (state is LoginAuthLoading) {
                          return const CircularProgressIndicator();
                        }
                        return LoginButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              // Navigate to main screen
                              context.read<AuthenticationCubit>().login(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                            }
                          },
                        );
                      },
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    const OrSignWithWidget(),
                    const SizedBox(
                      height: 25,
                    ),
                    const LoginSocialMedia(),
                    const SizedBox(
                      height: 25,
                    ),
                    const LoginGoToSignUpScreen(),
                    const SizedBox(
                      height: 30,
                    ),
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
