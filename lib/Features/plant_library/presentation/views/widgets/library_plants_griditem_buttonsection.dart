import 'package:flutter/material.dart';

class LibraryPlantsGridItemButtomSection extends StatelessWidget {
  const LibraryPlantsGridItemButtomSection(
      {super.key, required this.description});
  final String description;
  @override
  Widget build(BuildContext context) {
    // Get screen dimensions for responsive sizing
    final screenWidth = MediaQuery.of(context).size.width;

    // Calculate responsive padding and button size
    final padding = screenWidth * 0.025; // 2.5% of screen width

    // Calculate font size based on screen width
    final fontSize =
        screenWidth < 400 ? 10.0 : (screenWidth < 700 ? 11.0 : 12.0);

    // Adjust max lines to prevent overflow in 2-column layout
    final maxLines = screenWidth < 400 ? 5 : (screenWidth < 600 ? 3 : 4);

    return Flexible(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(padding),
        decoration: const BoxDecoration(
          color: Color(0xFFD0E2B6),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
        ),
        child: Stack(
          children: [
            Text(
              description,
              maxLines: maxLines,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: fontSize,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
