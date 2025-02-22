import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mazraaty/Core/utils/app_router.dart';
import 'package:mazraaty/Core/widgets/dialog_helper.dart';
import 'package:mazraaty/Features/authentication/presentation/manager/Authentication/authentication_cubit.dart';
import 'package:mazraaty/Features/authentication/presentation/views/widgets/recoverpass_backbutton.dart';
import 'package:mazraaty/Features/authentication/presentation/views/widgets/recoverpass_button.dart';
import 'package:mazraaty/Features/authentication/presentation/views/widgets/recoverpass_email_textfeild.dart';
import 'package:mazraaty/Features/authentication/presentation/views/widgets/recoverpass_title.dart';

class RecoverPassViewBody extends StatelessWidget {
  RecoverPassViewBody({super.key});
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is ForgotPasswordLoading) {
          DialogHelper.showLoading(context);
        } else if (state is ForgotPasswordSuccess) {
          DialogHelper.hideLoading();
          DialogHelper.showSuccess(
            context,
            'Verification Sent!',
            'We\'ve sent a verification code to your email',
            () => GoRouter.of(context)
                .push(AppRouter.kVerifyCodeView, extra: emailController.text),
          );
        } else if (state is ForgotPasswordError) {
          DialogHelper.hideLoading();
          DialogHelper.showError(
            context,
            'Sending Failed',
            state.errorMessage,
          );
        }
      },
      builder: (context, state) {
        return Center(
          child: Column(
            children: [
              RecoverPassBackButton(
                onPressed: () {
                  GoRouter.of(context).pop();
                },
              ),
              const SizedBox(
                height: 110,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(children: [
                  const RecoverPassTitle(),
                  const SizedBox(
                    height: 30,
                  ),
                  Form(
                    key: formKey,
                    child: RecoverPassEmailTextFeild(
                        emailController: emailController),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  RecoverPassButton(onPressed: () {
                    if (formKey.currentState!.validate()) {
                      context
                          .read<AuthenticationCubit>()
                          .sendOtp(emailController.text);
                    }
                  }),
                ]),
              ),
            ],
          ),
        );
      },
    );
  }
}
