import 'package:flutter/material.dart';
import 'package:mazraaty/constants.dart';

class RecoverPassBackButton extends StatelessWidget {
  const RecoverPassBackButton({super.key, required this.onPressed});
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Align(
        alignment: Alignment.topLeft,
        child: IconButton(
          onPressed: onPressed,
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 30,
            color: kMainColor,
          ),
        ),
      ),
    );
  }
}
