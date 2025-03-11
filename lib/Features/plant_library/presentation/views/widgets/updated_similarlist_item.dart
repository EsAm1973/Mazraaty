import 'package:flutter/material.dart';
import 'package:mazraaty/Core/utils/styles.dart';

class UpdatedDetailsSimilarItem extends StatelessWidget {
  const UpdatedDetailsSimilarItem(
      {super.key, required this.imagePath, required this.name});
  final String imagePath;
  final String name;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              imagePath,
              width: 130,
              height: 130,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            name,
            style: Styles.textStyle16.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
