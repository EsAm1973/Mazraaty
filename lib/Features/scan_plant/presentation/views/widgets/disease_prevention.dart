import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mazraaty/Features/scan_plant/presentation/views/widgets/disease_prevention_item.dart';

class DiseasePrevention extends StatelessWidget {
  DiseasePrevention({super.key});
  final List<Map<String, String>> preventions = [
    {
      "title": "Ensure Proper Air Circulation",
      "description":
          "Space mint plants adequately to allow air to circulate, reducing moisture buildup that encourages fungal growth."
    },
    {
      "title": "Water at the Base of the Plant",
      "description":
          "Avoid wetting the leaves by watering the soil directly, which helps prevent the spread of fungal spores."
    },
    {
      "title": "Remove Infected Leaves Promptly",
      "description":
          "Regularly inspect plants and immediately remove any infected leaves to stop the rust from spreading to healthy parts."
    },
    {
      "title": "Sanitize Tools and Garden Area",
      "description":
          "Clean gardening tools and remove plant debris from around the mint plants to prevent overwintering of rust spores."
    },
    {
      "title": "Rotate Mint Crops Annually",
      "description":
          "Avoid planting mint in the same location each year to reduce the risk of rust spores persisting in the soil and reinfecting new plants."
    },
  ];

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
        ...preventions.map((symptom) {
          return PreventionItem(
            title: symptom["title"]!,
            description: symptom["description"]!,
          );
        }),
      ],
    );
  }
}
