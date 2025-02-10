import 'package:flutter/material.dart';
import 'package:mazraaty/Core/utils/styles.dart';
import 'package:mazraaty/constants.dart';

class SkipButton extends StatelessWidget {
  const SkipButton({super.key, required this.pageController});
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 26,
      right: 27,
      child: TextButton(
        onPressed: () {
          pageController.jumpToPage(onboardingData.length - 1);
        },
        child: Text(
          'Skip',
          style: Styles.textStyle20.copyWith(
            color: kMainColor,
          ),
        ),
      ),
    );
  }
}
