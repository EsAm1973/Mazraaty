import 'package:flutter/material.dart';
import 'package:mazraaty/Core/utils/styles.dart';

class UpdatedDetailsCareSection extends StatelessWidget {
  const UpdatedDetailsCareSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Care",
          style: Styles.textStyle23.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildCareItem(
                  'assets/images/toughness.png', "Toughness", "High"),
              _buildCareItem(
                  'assets/images/maintance.png', "Maintenance", "Medium"),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCareItem(String image, String title, String value) {
    return Row(
      children: [
        Image.asset(image, width: 30, height: 30),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Styles.textStyle15.copyWith(color: Colors.black54),
            ),
            Text(
              value,
              style: Styles.textStyle16.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}
