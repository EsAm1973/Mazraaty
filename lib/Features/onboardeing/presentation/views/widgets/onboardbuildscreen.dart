import 'package:flutter/material.dart';
import 'package:mazraaty/Core/utils/styles.dart';
import 'package:mazraaty/constants.dart';

class OnboardingPage extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;
  final Color primaryColor;
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AspectRatio(
          aspectRatio: 5 / 3.5,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.contain, // Changed to contain for consistent sizing
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        buildMultiColorTitle(),
        const SizedBox(height: 20),
        SizedBox(
          width: 290,
          child: Text(
            textAlign: TextAlign.center,
            subtitle,
            style: Styles.textStyle16,
          ),
        ),
        const SizedBox(height: 40), // Add bottom spacing
      ],
    );
  }

  Widget buildMultiColorTitle() {
    final parts = title.split('*');
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: parts.first,
            style: Styles.textStyle38.copyWith(
              color: Colors.black,
              fontFamily: kfontFamily,
            ),
          ),
          if (parts.length > 1)
            TextSpan(
              text: parts.last,
              style: Styles.textStyle38.copyWith(
                color: primaryColor,
                fontFamily: kfontFamily,
              ),
            ),
        ],
      ),
    );
  }
}
