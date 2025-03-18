import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mazraaty/Features/scan_plant/presentation/views/widgets/disease_remedies_item.dart';

class DiseaseHomeRemedies extends StatelessWidget {
  final List<Map<String, String>> remedies = [
    {
      "title": "Baking Soda Spray",
      "description":
          "Mix baking soda with water and spray it on the infected mint leaves every 7-10 days to alter the plant's surface pH and inhibit fungal growth."
    },
    {
      "title": "Neem Oil",
      "description":
          "Prepare a neem oil solution with water and apply it to the affected leaves. Neem oil helps kill the fungus with its antifungal properties."
    },
    {
      "title": "Garlic Spray",
      "description":
          "Blend garlic with water, strain it, and spray the mixture on the infected leaves. Garlic acts as a natural fungicide and can prevent the spread of rust."
    },
    {
      "title": "Milk Spray",
      "description":
          "Dilute milk with water and spray it on the affected areas of the plant. The milk helps boost the plant’s defense against fungal infections."
    },
  ];

  DiseaseHomeRemedies({super.key});

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
              title: remedies[index]["title"]!,
              description: remedies[index]["description"]!,
            );
          },
        ),
      ],
    );
  }
}
