import 'package:flutter/material.dart';
import 'package:mazraaty/Features/plant_library/presentation/views/widgets/library_plants_griditem.dart';
import 'package:mazraaty/constants.dart';

class LibraryPlantGrid extends StatelessWidget {
  const LibraryPlantGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 25,
        mainAxisSpacing: 15,
        childAspectRatio: 0.72,
      ),
      itemCount: libraryPlantsTest.length,
      itemBuilder: (context, index) {
        final plant = libraryPlantsTest[index];
        return PlantCard(
          title: plant['title'],
          description: plant['description'],
          imagePath: plant['image'],
        );
      },
    );
  }
}
