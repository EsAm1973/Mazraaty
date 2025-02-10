import 'package:flutter/material.dart';
import 'package:mazraaty/Core/utils/styles.dart';
import 'package:mazraaty/constants.dart';

class OnboardingPage extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;
  final Color primaryColor; // Add color parameters
  final Color secondaryColor;

  const OnboardingPage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    this.primaryColor = kMainColor,
    this.secondaryColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 27, vertical: 26),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 35,
          ),
          SizedBox(
            width: double.infinity,
            child: Image.asset(
              imagePath,
              fit: BoxFit.contain,
            ),
          ),
          buildMultiColorTitle(),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: 300,
            child: Text(
              textAlign: TextAlign.center,
              subtitle,
              style: Styles.textStyle16,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMultiColorTitle() {
    final parts = title.split('*'); // Use '*' as color separator
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
              text: parts.first,
              style: Styles.textStyle38.copyWith(
                color: Colors.black,
                fontFamily: kfontFamily,
              )),
          if (parts.length > 1)
            TextSpan(
                text: parts.last,
                style: Styles.textStyle38.copyWith(
                  color: primaryColor,
                  fontFamily: kfontFamily,
                )),
        ],
      ),
    );
  }
}
