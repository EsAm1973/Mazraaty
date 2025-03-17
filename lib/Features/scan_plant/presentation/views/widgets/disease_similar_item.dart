import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DiseaseSimilarItem extends StatelessWidget {
  const DiseaseSimilarItem(
      {super.key, required this.imagePath, required this.name});
  final String imagePath;
  final String name;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              imagePath,
              width: 130,
              height: 130,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            name,
            style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
