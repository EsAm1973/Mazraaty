import 'package:flutter/material.dart';
import 'package:mazraaty/Core/utils/styles.dart';
import 'package:mazraaty/constants.dart';

class TitlePackageViews extends StatelessWidget {
  const TitlePackageViews({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Text(
        'Choose your plan',
        style: Styles.textStyle26.copyWith(
          fontFamily: kfontFamily,
          color: kMainColor,
        ),
      ),
    );
  }
}
