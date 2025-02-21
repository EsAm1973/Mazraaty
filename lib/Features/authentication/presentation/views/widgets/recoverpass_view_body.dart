import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mazraaty/Core/utils/app_router.dart';
import 'package:mazraaty/Features/authentication/presentation/views/widgets/recoverpass_backbutton.dart';
import 'package:mazraaty/Features/authentication/presentation/views/widgets/recoverpass_button.dart';
import 'package:mazraaty/Features/authentication/presentation/views/widgets/recoverpass_email_textfeild.dart';
import 'package:mazraaty/Features/authentication/presentation/views/widgets/recoverpass_title.dart';
import 'package:mazraaty/constants.dart';

class RecoverPassViewBody extends StatelessWidget {
  RecoverPassViewBody({super.key});
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(children: [
              const RecoverPassTitle(),
              const SizedBox(
                height: 30,
              ),
              Form(
                key: formKey,
                child:
                    RecoverPassEmailTextFeild(emailController: emailController),
              ),
              const SizedBox(
                height: 30,
              ),
              RecoverPassButton(onPressed: () {
                if (formKey.currentState!.validate()) {
                  //Navigate and make logic
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Email Send, Check Your Mail'),
                    ),
                  );
                }
              }),
            ]),
          ),
        ],
      ),
    );
  }
}
