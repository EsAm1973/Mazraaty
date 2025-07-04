import 'package:flutter/material.dart';
import 'package:mazraaty/Core/utils/styles.dart';
import 'package:mazraaty/constants.dart';

class DeleteAccountTitle extends StatelessWidget {
  const DeleteAccountTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Delete Account',
          style: Styles.textStyle30.copyWith(
            fontFamily: kfontFamily,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          textAlign: TextAlign.center,
          'Please enter your password to delete your \naccount',
          style: Styles.textStyle15.copyWith(
            color: Colors.grey,
          ),
        )
      ],
    );
  }
}
