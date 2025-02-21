import 'package:flutter/material.dart';
import 'package:mazraaty/Core/widgets/custom_button.dart';

class ResetPassButton extends StatelessWidget {
  const ResetPassButton({super.key, required this.onPressed});
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(
      text: 'Confirm',
      onPressed: onPressed,
    );
  }
}
