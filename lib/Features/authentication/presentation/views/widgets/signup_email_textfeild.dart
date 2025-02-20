import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mazraaty/Core/widgets/custom_textfeild.dart';
import 'package:mazraaty/constants.dart';

class SignUpEmailTextFeild extends StatelessWidget {
  const SignUpEmailTextFeild({super.key, required this.emailController});
  final TextEditingController emailController;
  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: emailController,
      hintText: 'user@email.com',
      keyboardType: TextInputType.emailAddress,
      preffixIcon: const Icon(
        FontAwesomeIcons.solidEnvelope,
        color: kMainColor,
      ),
      onChanged: (value) {},
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email address';
        }
        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
          return 'Please enter a valid email address';
        }
        return null;
      },
    );
  }
}
