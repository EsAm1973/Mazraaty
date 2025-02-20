import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mazraaty/Core/widgets/custom_textfeild.dart';
import 'package:mazraaty/constants.dart';

class SignUpPasswordTextFeild extends StatefulWidget {
  const SignUpPasswordTextFeild({super.key, required this.passwordController});
  final TextEditingController passwordController;
  @override
  State<SignUpPasswordTextFeild> createState() =>
      _SignUpPasswordTextFeildState();
}

class _SignUpPasswordTextFeildState extends State<SignUpPasswordTextFeild> {
  bool _obscurePassword = true;
  @override
  void dispose() {
    super.dispose();
    widget.passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: widget.passwordController,
      obscureText: _obscurePassword,
      hintText: 'Password',
      preffixIcon: const Icon(
        FontAwesomeIcons.lock,
        color: kMainColor,
        size: 24,
      ),
      suffixIcon: IconButton(
        icon: Icon(
          _obscurePassword
              ? FontAwesomeIcons.solidEye
              : FontAwesomeIcons.solidEyeSlash,
          color: kMainColor,
        ),
        onPressed: () {
          setState(() {
            _obscurePassword = !_obscurePassword;
          });
        },
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a password';
        }
        if (value.length < 6) {
          return 'Password must be at least 6 characters';
        }
        return null;
      },
    );
  }
}
