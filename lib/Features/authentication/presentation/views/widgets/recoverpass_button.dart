import 'package:flutter/material.dart';
import 'package:mazraaty/Core/widgets/custom_button.dart';

class RecoverPassButton extends StatelessWidget {
  const RecoverPassButton({super.key, required this.onPressed});
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(
      text: 'Recover password',
      onPressed: onPressed,
    );
  }
}
