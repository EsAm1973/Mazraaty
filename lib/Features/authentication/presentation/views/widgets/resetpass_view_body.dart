import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mazraaty/Core/widgets/custom_textfeild.dart';
import 'package:mazraaty/Features/authentication/presentation/views/widgets/resetpass_email_textfeild.dart';
import 'package:mazraaty/Features/authentication/presentation/views/widgets/resetpass_title.dart';
import 'package:mazraaty/constants.dart';

class ResetPassViewBody extends StatelessWidget {
  ResetPassViewBody({super.key});
  final TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const ResetPassTitle(),
            ResetPassEmailTextFeild(emailController: emailController),
          ],
        ),
      ),
    );
  }
}