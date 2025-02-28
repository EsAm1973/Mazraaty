import 'package:flutter/material.dart';
import 'package:mazraaty/Core/utils/styles.dart';
import 'package:mazraaty/constants.dart';

class LibraryPlantsGridItemTopSection extends StatelessWidget {
  const LibraryPlantsGridItemTopSection(
      {super.key, required this.title, required this.imagePath});
  final String title;
  final String imagePath;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: kMainColor.withOpacity(0.32),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Image.network(
              imagePath,
              height: 80,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 6),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              title,
              style: Styles.textStyle16.copyWith(color: kMainColor),
            ),
          ),
        ],
      ),
    );
  }
}
