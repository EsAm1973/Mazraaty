import 'package:flutter/material.dart';
import 'package:mazraaty/Core/utils/styles.dart';

class UpdatedDetailsScientificClassification extends StatelessWidget {
  const UpdatedDetailsScientificClassification({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Scientific classification",
          style: Styles.textStyle23.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Column(
          children: [
            _buildClassificationRow("Genus", "Mentha"),
            _buildClassificationRow("Family", "Lamiaceae"),
            _buildClassificationRow("Order", "Lamiales"),
            _buildClassificationRow("Class", "Magnoliopsida, Dicotyledons"),
            _buildClassificationRow(
              "Phylum",
              "Tracheophyta – Vascular plants",
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildClassificationRow(
    String label,
    String value,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Styles.textStyle16,
          ),
          Text(value,
              style: Styles.textStyle16.copyWith(
                fontWeight: FontWeight.bold,
              )),
        ],
      ),
    );
  }
}
