import 'package:flutter/material.dart';
import 'package:mazraaty/Core/utils/styles.dart';
import 'package:mazraaty/constants.dart';

class HomePremiumUpgradeCard extends StatelessWidget {
  const HomePremiumUpgradeCard({super.key, required this.onSubscribeTap});
  final VoidCallback onSubscribeTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.eco,
                color: Colors.green,
                size: 24,
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                'Upgrade to Premium',
                style: Styles.textStyle20.copyWith(
                  color: Colors.green,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.chevron_right,
                color: Colors.green.shade700,
                size: 24,
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            'Get unlimited scans, advanced insights, and priority support',
            style: Styles.textStyle16.copyWith(
              color: Colors.black54,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onSubscribeTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: kMainColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Subscribe Now',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
