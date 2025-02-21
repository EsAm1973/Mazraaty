import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mazraaty/Core/utils/app_router.dart';
import 'package:mazraaty/Features/authentication/presentation/views/widgets/resetpass_backbutton.dart';
import 'package:mazraaty/Features/authentication/presentation/views/widgets/resetpass_button.dart';
import 'package:mazraaty/Features/authentication/presentation/views/widgets/resetpass_confirmpass.dart';
import 'package:mazraaty/Features/authentication/presentation/views/widgets/resetpass_newtextfeild.dart';
import 'package:mazraaty/Features/authentication/presentation/views/widgets/resetpass_title.dart';

class ResetPassViewBody extends StatelessWidget {
  ResetPassViewBody({super.key});
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            ResetPassBackButton(onPressed: () {
              GoRouter.of(context).pop();
            }),
            const SizedBox(
              height: 110,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Form(
                key: formKey,
                child: Column(children: [
                  const ResetPassTitle(),
                  const SizedBox(
                    height: 36,
                  ),
                  ResetPassNewPasswordTextFeild(
                    passwordController: passwordController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ResetPassConfirmPasswordTextFeild(
                    passwordController: passwordController,
                    confirmPasswordController: confirmPasswordController,
                  ),
                  const SizedBox(
                    height: 44,
                  ),
                  ResetPassButton(onPressed: () {
                    if (formKey.currentState!.validate()) {
                      //Navigate and make logic
                      GoRouter.of(context).pushReplacement(AppRouter.kLoginView);
                    }
                  }),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
