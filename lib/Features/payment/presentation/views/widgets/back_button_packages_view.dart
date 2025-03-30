import 'package:flutter/material.dart';
import 'package:mazraaty/constants.dart';

class BackButtonPackageView extends StatelessWidget {
  const BackButtonPackageView({super.key, this.onPressed});
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: const Icon(
        Icons.arrow_back_ios_new,
        size: 32,
        color: kMainColor,
      ),
    );
  }
}
