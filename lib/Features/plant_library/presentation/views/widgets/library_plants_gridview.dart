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
            return _buildEmptyState(context, state);
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
                  imagePath: plant.headerImage,
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

  Widget _buildEmptyState(BuildContext context, LibrarySuccess state) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Get the current category name
    final currentCategory = state.selectedIndex < state.categories.length
        ? state.categories[state.selectedIndex].name
        : 'this category';

    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animated plant icon with gradient background
              Container(
                width: screenWidth * 0.35,
                height: screenWidth * 0.35,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFE8F5E8),
                      Color(0xFFD0E2B6),
                      Color(0xFFB8D4A0),
                    ],
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF3E7B27).withValues(alpha: 0.2),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.eco_rounded,
                  size: screenWidth * 0.15,
                  color: const Color(0xFF3E7B27),
                ),
              ),

              SizedBox(height: screenHeight * 0.04),

              // Main title
              Text(
                'No Plants Found',
                style: TextStyle(
                  fontSize: screenWidth * 0.06,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF3E7B27),
                  letterSpacing: 0.5,
                ),
              ),

              SizedBox(height: screenHeight * 0.015),

              // Subtitle with category name
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    color: Colors.grey[600],
                    height: 1.5,
                  ),
                  children: [
                    const TextSpan(text: 'No plants available in '),
                    TextSpan(
                      text: '"$currentCategory"',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF3E7B27),
                      ),
                    ),
                    const TextSpan(text: ' category at the moment.'),
                  ],
                ),
              ),

              SizedBox(height: screenHeight * 0.03),

              // Suggestions container
              Container(
                padding: EdgeInsets.all(screenWidth * 0.05),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xFF3E7B27).withValues(alpha: 0.2),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.lightbulb_outline_rounded,
                      size: screenWidth * 0.08,
                      color: const Color(0xFF3E7B27).withValues(alpha: 0.7),
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    Text(
                      'Try these suggestions:',
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF3E7B27),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    _buildSuggestionItem(
                      context,
                      Icons.category_rounded,
                      'Browse other categories',
                      screenWidth,
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    _buildSuggestionItem(
                      context,
                      Icons.search_rounded,
                      'Try searching for specific plants',
                      screenWidth,
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    _buildSuggestionItem(
                      context,
                      Icons.refresh_rounded,
                      'Check back later for new additions',
                      screenWidth,
                    ),
                  ],
                ),
              ),

              SizedBox(height: screenHeight * 0.04),

              // Action button
              Container(
                width: double.infinity,
                height: screenHeight * 0.06,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color(0xFF3E7B27),
                      Color(0xFF4A8B32),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF3E7B27).withValues(alpha: 0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Navigate to "All" category (index 0)
                    if (state.categories.isNotEmpty) {
                      context.read<LibraryCubit>().selectCategory(0, state.categories);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  icon: Icon(
                    Icons.explore_rounded,
                    color: Colors.white,
                    size: screenWidth * 0.05,
                  ),
                  label: Text(
                    'Explore All Plants',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSuggestionItem(BuildContext context, IconData icon, String text, double screenWidth) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: const Color(0xFF3E7B27).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: screenWidth * 0.04,
            color: const Color(0xFF3E7B27),
          ),
        ),
        SizedBox(width: screenWidth * 0.03),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: screenWidth * 0.035,
              color: Colors.grey[700],
              height: 1.3,
            ),
          ),
        ),
      ],
    );
  }
}
