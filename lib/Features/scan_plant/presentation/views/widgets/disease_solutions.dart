import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mazraaty/Features/scan_plant/data/models/soluation.dart';
import 'package:mazraaty/Features/scan_plant/presentation/views/widgets/disease_solution_item.dart';

class DiseaseSoluations extends StatelessWidget {
  const DiseaseSoluations({super.key, required this.solutions});
  final List<Solution> solutions;

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
        ...solutions.map((solution) {
          return DiseaseSoluationsItem(
            title: solution.title,
            description: solution.description,
          );
        }),
      ],
    );
  }
}
