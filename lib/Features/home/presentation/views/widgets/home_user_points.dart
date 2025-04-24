import 'package:flutter/material.dart';
import 'package:mazraaty/Core/utils/styles.dart';

class HomePointWidegt extends StatelessWidget {
  const HomePointWidegt(
      {super.key, required this.points, required this.onHowToEarnTap});
  final int points;
  final VoidCallback? onHowToEarnTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(
              Icons.star,
              color: Color(0xFFFFD700),
              size: 30,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              '$points Points',
              style: Styles.textStyle23,
            ),
          ],
        ),
        const SizedBox(
          width: 8,
        ),
        GestureDetector(
          onTap: onHowToEarnTap,
          child: Text(
            'How to earn?',
            style: Styles.textStyle16.copyWith(
              color: Colors.grey[600],
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
