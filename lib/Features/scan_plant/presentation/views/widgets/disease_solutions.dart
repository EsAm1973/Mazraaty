import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mazraaty/Features/scan_plant/presentation/views/widgets/disease_solution_item.dart';

class DiseaseSoluations extends StatelessWidget {
  DiseaseSoluations({super.key});
  final List<Map<String, String>> solutions = [
    {
      "title": "Remove Infected Leaves",
      "description":
          "At the first sign of infection, remove and dispose of infected leaves to prevent the spread of rust spores. Do not compost these leaves, as the spores can survive and re-infect plants."
    },
    {
      "title": "Improve Air Circulation",
      "description":
          "Ensure proper spacing between plants to promote good airflow, reducing moisture levels around the plants. Prune any overcrowded areas to maintain air circulation."
    },
    {
      "title": "Watering Practices",
      "description":
          "Water the plants at the base, keeping the leaves dry. Watering in the early morning helps the plant dry out during the day, reducing the chances of fungal growth."
    },
    {
      "title": "Organic Fungicide Application",
      "description":
          "Use organic fungicides like neem oil or copper-based sprays to treat and prevent rust infections. Apply these treatments early for the best effect and continue monitoring for new outbreaks."
    },
    {
      "title": "Sanitize Garden Tools",
      "description":
          "Regularly clean and disinfect gardening tools, especially after handling infected plants, to prevent the spread of rust spores to healthy plants."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Solutions",
          style:
              GoogleFonts.montserrat(fontSize: 23, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10.0),
        ...solutions.map((symptom) {
          return DiseaseSoluationsItem(
            title: symptom["title"]!,
            description: symptom["description"]!,
          );
        }),
      ],
    );
  }
}
