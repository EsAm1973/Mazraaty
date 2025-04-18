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
    // Get screen width for responsive sizing
    final screenWidth = MediaQuery.of(context).size.width;

    // Calculate available width in a 2-column layout
    final availableWidth = (screenWidth / 2) - (screenWidth * 0.05); // Account for spacing

    return Container(
      // Use available width instead of fixed width
      width: double.infinity,
      // Constrain height to prevent overflow in GridView
      constraints: BoxConstraints(
        maxWidth: availableWidth,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: screenWidth < 400 ? 3 : 4, // Smaller blur on small screens
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Column(
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
