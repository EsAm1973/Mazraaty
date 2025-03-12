import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mazraaty/Core/utils/styles.dart';

class UpdatedDetailsDiseases extends StatelessWidget {
  const UpdatedDetailsDiseases(
      {super.key, required this.pests, required this.diseases});
  final List<String> pests;
  final List<String> diseases;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(
                'assets/images/bug.png', // أيقونة الحشرات
                width: 24,
                height: 24,
              ),
              const SizedBox(width: 8),
              Text(
                "Pests & Diseases",
                style: Styles.textStyle18.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildCategoryColumn("Pests", pests, Colors.red.shade400),
              const SizedBox(width: 16),
              _buildDynamicDivider(),
              const SizedBox(width: 16),
              _buildCategoryColumn("Diseases", diseases, Colors.pink.shade400),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryColumn(String title, List<String> items, Color color) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Styles.textStyle16.copyWith(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          ...items.map((item) => Text("- $item", style: Styles.textStyle16)),
        ],
      ),
    );
  }

  Widget _buildDynamicDivider() {
    int maxLength = max(pests.length, diseases.length);
    double dividerHeight =
        maxLength * 30.0; // كل عنصر يأخذ تقريبًا 20 بكسل في الارتفاع

    return Container(
      width: 2,
      height: dividerHeight,
      color: Colors.black54,
    );
  }
}
