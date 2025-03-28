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
    const fullUrlImage = 'https://b290-196-129-56-101.ngrok-free.app/storage/';
    return Container(
      width: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          LibraryPlantsGridItemTopSection(
            imagePath: fullUrlImage + imagePath,
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
