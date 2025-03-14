import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UpdatedDetailsCareSection extends StatelessWidget {
  const UpdatedDetailsCareSection(
      {super.key, required this.toughness, required this.maintance});
  final String toughness;
  final String maintance;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Care",
          style:
              GoogleFonts.montserrat(fontSize: 23, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildCareItem(
                  'assets/images/toughness.png', "Toughness", toughness),
              _buildCareItem(
                  'assets/images/maintance.png', "Maintenance", maintance),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCareItem(String image, String title, String value) {
    return Row(
      children: [
        Image.asset(image, width: 30, height: 30),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style:
                  GoogleFonts.montserrat(fontSize: 15, color: Colors.black54),
            ),
            Text(
              value,
              style: GoogleFonts.montserrat(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}
