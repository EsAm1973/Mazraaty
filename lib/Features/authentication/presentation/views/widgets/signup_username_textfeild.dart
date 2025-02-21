import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mazraaty/Core/widgets/custom_textfeild.dart';
import 'package:mazraaty/constants.dart';

class SignUpUserNameTextFeild extends StatelessWidget {
  const SignUpUserNameTextFeild({super.key, required this.nameController});
  final TextEditingController nameController;
  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: nameController,
      hintText: 'Username',
      keyboardType: TextInputType.name,
      preffixIcon: const Icon(
        FontAwesomeIcons.solidUser,
        color: kMainColor,
      ),
      onChanged: (value) {},
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your Username';
        }

        final nameRegExp = RegExp(r"^[a-zA-Z]+(?:[\s'-][a-zA-Z]+)*$");
        if (!nameRegExp.hasMatch(value)) {
          return 'Please enter a valid Username (only letters, spaces, hyphens, and apostrophes are allowed)';
        }
        return null;
      },
    );
  }
}
