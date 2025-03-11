import 'package:flutter/material.dart';
import 'package:mazraaty/Core/utils/styles.dart';

class UpdatedDetailsConditionsSection extends StatelessWidget {
  const UpdatedDetailsConditionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Conditions",
          style: Styles.textStyle23.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            _buildConditionCard(
              image: 'assets/images/sun.png',
              title: "Sunlight",
              value: "Full Sun",
            ),
            const SizedBox(width: 12),
            _buildConditionCard(
              image: 'assets/images/location.png',
              title: "Hardness zone",
              value: "3–9",
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildConditionCard({
    required String image,
    required String title,
    required String value,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(image, width: 30, height: 30),
            const SizedBox(
              width: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(width: 8),
                Text(
                  title,
                  style: Styles.textStyle15.copyWith(color: Colors.black54),
                ),
                Text(
                  value,
                  style:
                      Styles.textStyle16.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
