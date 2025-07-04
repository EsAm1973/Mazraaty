import 'package:flutter/material.dart';
import 'package:mazraaty/Features/plant_library/presentation/views/widgets/library_category_list.dart';
import 'package:mazraaty/Features/plant_library/presentation/views/widgets/library_plants_gridview.dart';
import 'package:mazraaty/Features/plant_library/presentation/views/widgets/library_search_textfeild.dart';
import 'package:mazraaty/constants.dart';

class LibraryViewBody extends StatelessWidget {
  const LibraryViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            kScaffoldColor,
            kScaffoldColor.withValues(alpha: 0.8),
            Colors.white.withValues(alpha: 0.9),
          ],
          stops: const [0.0, 0.3, 1.0],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.06, // More responsive padding
            vertical: screenHeight * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(bottom: screenHeight * 0.025),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Plant Library',
                      style: TextStyle(
                        fontSize: screenWidth * 0.07,
                        fontWeight: FontWeight.bold,
                        color: kMainColor,
                        fontFamily: kfontFamily,
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.005),
                    Text(
                      'Discover and explore our collection',
                      style: TextStyle(
                        fontSize: screenWidth * 0.035,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w400,
                        fontFamily: kfontFamily,
                      ),
                    ),
                  ],
                ),
              ),

              // Search Section
              const LibrarySearchTextFeild(),
              SizedBox(height: screenHeight * 0.025),

              // Categories Section
              const LibraryCategoriesList(),
              SizedBox(height: screenHeight * 0.02),

              // Plants Grid Section
              const Expanded(child: LibraryPlantGrid()),
            ],
          ),
        ),
      ),
    );
  }
}
