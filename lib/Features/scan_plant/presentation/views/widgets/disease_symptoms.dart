import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mazraaty/Features/scan_plant/data/models/symptom.dart';
import 'package:mazraaty/Features/scan_plant/presentation/views/widgets/disease_symptoms_item.dart';

class SymptomsScreen extends StatelessWidget {
  final List<Symptom> symptoms;

  const SymptomsScreen({super.key, required this.symptoms});

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
            title: symptom.title,
            description: symptom.description,
          );
        }),
      ],
    );
  }
}
