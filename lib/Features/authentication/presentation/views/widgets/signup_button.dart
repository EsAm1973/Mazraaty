import 'package:flutter/material.dart';
import 'package:mazraaty/Core/widgets/custom_button.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({super.key, this.onPressed});
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(
      text: 'Sign Up',
      onPressed: onPressed,
    );
  }
}
