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
    final screenHeight = MediaQuery.of(context).size.height;

    // Calculate responsive padding and image height for 2-column layout
    final padding = screenWidth * 0.03; // 3% of screen width
    // Calculate image height based on available width in a 2-column layout
    // Each column gets roughly (screenWidth / 2) minus spacing
    final columnWidth = (screenWidth / 2) - (screenWidth * 0.05);
    final imageHeight = columnWidth * 0.6; // Image height proportional to column width

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(padding),
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
            child: CachedNetworkImage(
              height: imageHeight,
              imageUrl: imagePath,
              errorWidget: (context, url, error) => const Icon(
                Icons.error,
              ),
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              ),
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: screenHeight * 0.01), // Responsive spacing
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              title,
              style: screenWidth < 400
                ? Styles.textStyle15.copyWith(color: kMainColor)
                : Styles.textStyle16.copyWith(color: kMainColor),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
