import 'package:flutter/material.dart';
import 'package:mazraaty/Features/authentication/presentation/views/widgets/recoverpass_button.dart';
import 'package:mazraaty/Features/authentication/presentation/views/widgets/recoverpass_email_textfeild.dart';
import 'package:mazraaty/Features/authentication/presentation/views/widgets/recoverpass_title.dart';

class RecoverPassViewBody extends StatelessWidget {
  RecoverPassViewBody({super.key});
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
          ],
        ),
      ),
    );
  }
}
