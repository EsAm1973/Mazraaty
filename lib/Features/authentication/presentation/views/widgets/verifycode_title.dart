import 'package:flutter/material.dart';
import 'package:mazraaty/Core/utils/styles.dart';
import 'package:mazraaty/constants.dart';

class VerifyCodeTitle extends StatelessWidget {
  const VerifyCodeTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Verify Code',
          style: Styles.textStyle30.copyWith(
            fontFamily: kfontFamily,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          textAlign: TextAlign.center,
          'Please enter thr code we just sent to email \nuser@email.com',
          style: Styles.textStyle15.copyWith(
            color: Colors.grey,
          ),
        )
      ],
    );
  }
}
