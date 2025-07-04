import 'package:flutter/material.dart';
import 'package:mazraaty/Core/widgets/custom_button.dart';

class PayNowButton extends StatelessWidget {
  const PayNowButton({super.key, required this.onPressed});
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(
      text: 'Pay Now',
      onPressed: onPressed,
    );
  }
}
