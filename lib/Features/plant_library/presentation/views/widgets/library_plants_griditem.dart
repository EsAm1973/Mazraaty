import 'package:flutter/material.dart';
import 'package:mazraaty/Features/plant_library/presentation/views/widgets/library_plants_griditem_buttonsection.dart';
import 'package:mazraaty/Features/plant_library/presentation/views/widgets/library_plants_griditem_topsection.dart';

class PlantCard extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;

  const PlantCard({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // Use available width instead of fixed width
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFD0E2B6), // Fill with bottom section color
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 5,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LibraryPlantsGridItemTopSection(
            imagePath: imagePath,
            title: title,
          ),
          LibraryPlantsGridItemButtomSection(
            description: description,
          ),
        ],
      ),
    );
  }
}
