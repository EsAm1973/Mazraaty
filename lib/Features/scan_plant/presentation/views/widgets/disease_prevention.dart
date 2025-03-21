import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mazraaty/Features/scan_plant/data/models/prevention.dart';
import 'package:mazraaty/Features/scan_plant/presentation/views/widgets/disease_prevention_item.dart';

class DiseasePrevention extends StatelessWidget {
  const DiseasePrevention({super.key, required this.preventions});
  final List<Prevention> preventions;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Preventions",
          style:
              GoogleFonts.montserrat(fontSize: 23, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10.0),
        ...preventions.map((prevention) {
          return PreventionItem(
            title: prevention.title,
            description: prevention.description,
          );
        }),
      ],
    );
  }
}
