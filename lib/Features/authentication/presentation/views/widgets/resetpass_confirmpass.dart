import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mazraaty/Core/widgets/custom_textfeild.dart';
import 'package:mazraaty/constants.dart';

class ResetPassConfirmPasswordTextFeild extends StatefulWidget {
  const ResetPassConfirmPasswordTextFeild(
      {super.key,
      required this.passwordController,
      required this.confirmPasswordController});
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  @override
  State<ResetPassConfirmPasswordTextFeild> createState() =>
      _ResetPassConfirmPasswordTextFeildState();
}

class _ResetPassConfirmPasswordTextFeildState
    extends State<ResetPassConfirmPasswordTextFeild> {
  bool _obscureConfirmPassword = true;
  @override
  void dispose() {
    super.dispose();
    widget.confirmPasswordController.dispose();
    widget.passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: widget.confirmPasswordController,
      hintText: 'Confirm your password',
      preffixIcon: const Icon(FontAwesomeIcons.lock, color: kMainColor),
      obscureText: _obscureConfirmPassword,
      suffixIcon: IconButton(
        icon: Icon(
          _obscureConfirmPassword
              ? FontAwesomeIcons.solidEye
              : FontAwesomeIcons.solidEyeSlash,
          color: kMainColor,
        ),
        onPressed: () {
          setState(() {
            _obscureConfirmPassword = !_obscureConfirmPassword;
          });
        },
      ),
      validator: (value) {
        if (value != widget.passwordController.text) {
          return 'Passwords do not match';
        }
        return null;
      },
      onChanged: (value) {},
    );
  }
}
