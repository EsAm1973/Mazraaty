import 'package:flutter/material.dart';
import 'package:mazraaty/Core/widgets/custom_button.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key, this.onPressed});
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(
      text: 'Login',
      onPressed: onPressed,
    );
  }
}
