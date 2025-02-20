import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mazraaty/Core/widgets/custom_textfeild.dart';
import 'package:mazraaty/constants.dart';

class SignUpPhoneTextFeild extends StatelessWidget {
  const SignUpPhoneTextFeild({super.key, required this.phoneController});
  final TextEditingController phoneController;
  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: phoneController,
      hintText: 'Phone Number',
      keyboardType: TextInputType.phone,
      preffixIcon: const Icon(
        FontAwesomeIcons.phone,
        color: kMainColor,
      ),
      onChanged: (value) {},
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your phone number';
        }
        final phoneRegExp = RegExp(r'^[0-9]+$');
        if (!phoneRegExp.hasMatch(value)) {
          return 'Please enter a valid phone number (only digits are allowed)';
        }
        if (value.length != 10) {
          return 'Phone number must be 10 digits long';
        }
        return null;
      },
    );
  }
}
