import 'package:flutter/material.dart';
import 'package:mazraaty/Core/utils/styles.dart';
import 'package:mazraaty/constants.dart';

class ResetPassTitle extends StatelessWidget {
  const ResetPassTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'New Password',
          style: Styles.textStyle30.copyWith(
            fontFamily: kfontFamily,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          textAlign: TextAlign.center,
          'Your new password must be different from \npreviously used passwords',
          style: Styles.textStyle15.copyWith(
            color: Colors.grey,
          ),
        )
      ],
    );
  }
}
