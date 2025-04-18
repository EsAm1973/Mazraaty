import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mazraaty/Core/utils/app_router.dart';
import 'package:mazraaty/Features/plant_library/presentation/manager/LibraryCubit/library_cubit.dart';
import 'package:mazraaty/Features/plant_library/presentation/views/widgets/library_plants_griditem.dart';

class LibraryPlantGrid extends StatelessWidget {
  const LibraryPlantGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LibraryCubit, LibraryState>(
      builder: (context, state) {
        if (state is LibrarySuccess) {
          if (state.selectedPlants.isEmpty) {
            return const Center(child: Text('No Plants in this category'));
          }
          // Get screen width to calculate responsive grid parameters
          final screenWidth = MediaQuery.of(context).size.width;

          // Keep a fixed 2-column layout as requested
          const crossAxisCount = 2;

          // Calculate spacing based on screen width
          final crossAxisSpacing = screenWidth * 0.05; // 5% of screen width
          final mainAxisSpacing = screenWidth * 0.03; // 3% of screen width

          // Calculate childAspectRatio based on screen size
          // Adjust aspect ratio to prevent overflow on different screen sizes
          final childAspectRatio = screenWidth < 400 ? 0.65 : (screenWidth < 600 ? 0.7 : 0.75);

          return GridView.builder(
            physics: const BouncingScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: crossAxisSpacing,
              mainAxisSpacing: mainAxisSpacing,
              childAspectRatio: childAspectRatio,
            ),
            itemCount: state.selectedPlants.length,
            itemBuilder: (context, index) {
              final plant = state.selectedPlants[index];
              return GestureDetector(
                onTap: () {
                  GoRouter.of(context)
                      .push(AppRouter.kUpdatedDetailsView, extra: plant);
                },
                child: PlantCard(
                  title: plant.name,
                  description: plant.description,
                  imagePath: plant.image,
                ),
              );
            },
          );
        } else if (state is LibraryError) {
          return Center(child: Text(state.errorMessage));
        } else if (state is LibraryLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return const Center(child: Text('Unknown Error'));
        }
      },
    );
  }
}
