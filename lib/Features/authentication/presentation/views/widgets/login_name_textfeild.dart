import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mazraaty/Core/widgets/custom_textfeild.dart';
import 'package:mazraaty/constants.dart';

class LoginFullNameTextFeild extends StatelessWidget {
  const LoginFullNameTextFeild({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomTextField(
      hintText: 'Full Name',
      preffixIcon: Icon(
        FontAwesomeIcons.solidUser,
        color: kMainColor,
        size: 24,
      ),
      onChanged: null,
      validator: null,
    );
  }
}
