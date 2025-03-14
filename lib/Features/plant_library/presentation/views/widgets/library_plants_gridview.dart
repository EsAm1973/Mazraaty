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
          return GridView.builder(
            physics: const BouncingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 25,
              mainAxisSpacing: 15,
              childAspectRatio: 0.72,
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
