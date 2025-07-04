import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mazraaty/Features/scan_plant/presentation/views/widgets/disease_similar_item.dart';
import 'package:mazraaty/constants.dart';

class DiseaseSimilarList extends StatelessWidget {
  const DiseaseSimilarList({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Disease Images",
          style:
              GoogleFonts.montserrat(fontSize: 23, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 160, // ارتفاع الـ ListView
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: similarPlants.length,
            itemBuilder: (context, index) {
              final plant = similarPlants[index];
              return DiseaseSimilarItem(
                imagePath: plant['image']!,
                name: plant['name']!,
              );
            },
          ),
        ),
      ],
    );
  }
}
