import 'package:flutter/material.dart';
import 'package:mazraaty/Core/utils/styles.dart';
import 'package:mazraaty/constants.dart';

class EmptyStateWidget extends StatelessWidget {
  final String message;
  final String subtitle;
  final IconData icon;

  const EmptyStateWidget({
    super.key,
    required this.message,
    this.subtitle = 'Data will appear as you scan plants',
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Animated empty state icon
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0.8, end: 1.0),
            duration: const Duration(milliseconds: 1500),
            curve: Curves.elasticOut,
            builder: (context, value, child) {
              return Transform.scale(
                scale: value,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: kMainColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    size: 60,
                    color: kMainColor.withOpacity(0.4),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 24),
          Text(
            message,
            style: Styles.textStyle18.copyWith(
              color: kMainColor.withOpacity(0.7),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: Styles.textStyle13.copyWith(
              color: kMainColor.withOpacity(0.5),
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
