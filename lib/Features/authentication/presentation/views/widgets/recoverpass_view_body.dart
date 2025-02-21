import 'package:flutter/material.dart';
import 'package:mazraaty/Core/widgets/custom_button.dart';
import 'package:mazraaty/Features/authentication/presentation/views/widgets/recoverpass_button.dart';
import 'package:mazraaty/Features/authentication/presentation/views/widgets/recoverpass_email_textfeild.dart';
import 'package:mazraaty/Features/authentication/presentation/views/widgets/recoverpass_title.dart';

class RecoverPassViewBody extends StatelessWidget {
  RecoverPassViewBody({super.key});
  final TextEditingController emailController = TextEditingController();
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
            RecoverPassEmailTextFeild(emailController: emailController),
            const SizedBox(
              height: 30,
            ),
            RecoverPassButton(onPressed: () {}),
          ],
        ),
      ),
    );
  }
}