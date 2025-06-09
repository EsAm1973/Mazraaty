import 'package:cached_network_image/cached_network_image.dart';
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
    // Get screen dimensions for responsive sizing
    final screenWidth = MediaQuery.of(context).size.width;

    // Calculate responsive padding and image height for 2-column layout
    final padding = screenWidth * 0.03; // 3% of screen width
    // Calculate image height based on available width in a 2-column layout
    // Each column gets roughly (screenWidth / 2) minus spacing
    final columnWidth = (screenWidth / 2) - (screenWidth * 0.05);
    final imageHeight = columnWidth * 0.6; // Image height proportional to column width

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: imageHeight,
        maxHeight: imageHeight + 50, // Allow some flexibility
      ),
      decoration: BoxDecoration(
        color: kMainColor.withValues(alpha: 0.32),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Stack(
        children: [
          // Image positioned to fill the entire container
          Positioned.fill(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(40),
              ),
              child: CachedNetworkImage(
                imageUrl: imagePath,
                errorWidget: (context, url, error) => const Icon(
                  Icons.error,
                ),
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Gradient overlay for better text contrast
          Positioned.fill(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(40),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.6),
                    ],
                    stops: const [0.0, 0.5, 1.0],
                  ),
                ),
              ),
            ),
          ),
          // Title positioned at the bottom with clear background
          Positioned(
            bottom: padding,
            left: padding,
            right: padding,
            child: Text(
              title,
              style: screenWidth < 400
                ? Styles.textStyle15.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  )
                : Styles.textStyle16.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
