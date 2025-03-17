import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mazraaty/Features/scan_plant/presentation/views/widgets/disease_symptoms_item.dart';

class SymptomsScreen extends StatelessWidget {
  final List<Map<String, String>> symptoms = [
    {
      "title": "Yellow Pustules",
      "description":
          "Small, round, raised pustules appear on the underside of mint leaves, usually orange, yellow, or reddish-brown in color. These are spore-producing structures of the fungus."
    },
    {
      "title": "Leaf Discoloration",
      "description":
          "The upper side of the leaves may show pale or yellow spots that correspond to the pustules on the underside."
    },
    {
      "title": "Premature Leaf Drop",
      "description":
          "Infected leaves often turn yellow and drop prematurely, leading to defoliation and stunted growth of the plant."
    },
    {
      "title": "Weakened Growth",
      "description":
          "Plants may exhibit reduced vigor, with slow or stunted growth due to the loss of photosynthetic ability in infected leaves."
    },
    {
      "title": "Stem Infection",
      "description":
          "In severe cases, rust can spread to the stems, causing swelling, discoloration, and cracking, which may further weaken the plant."
    },
  ];

  SymptomsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Symptoms",
          style:
              GoogleFonts.montserrat(fontSize: 23, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10.0),
        ...symptoms.map((symptom) {
          return SymptomItem(
            title: symptom["title"]!,
            description: symptom["description"]!,
          );
        }),
      ],
    );
  }
}
