import 'package:flutter/material.dart';
import 'package:mazraaty/Core/widgets/custom_button.dart';

class DeleteAccountButton extends StatelessWidget {
  const DeleteAccountButton({super.key, required this.onPressed});
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(
      text: 'Delete Account',
      onPressed: onPressed,
    );
  }
}
