import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mazraaty/Features/scan_plant/data/models/home_remedy.dart';
import 'package:mazraaty/Features/scan_plant/presentation/views/widgets/disease_remedies_item.dart';

class DiseaseHomeRemedies extends StatelessWidget {
  final List<HomeRemedy> remedies;

  const DiseaseHomeRemedies({super.key, required this.remedies});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Home Remedies",
          style:
              GoogleFonts.montserrat(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: remedies.length,
          itemBuilder: (context, index) {
            return RemedyItem(
              number: index + 1,
              title: remedies[index].title,
              description: remedies[index].description,
            );
          },
        ),
      ],
    );
  }
}
