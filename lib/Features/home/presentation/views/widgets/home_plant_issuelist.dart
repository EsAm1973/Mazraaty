import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mazraaty/Features/home/data/models/plant_issue.dart';
import 'package:mazraaty/Features/home/presentation/views/widgets/home_issue_listitem.dart';

class HomeRecentPlantIssue extends StatelessWidget {
  const HomeRecentPlantIssue({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Recent Plant Issues",
          style: GoogleFonts.montserrat(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(5),
                child: HomePlantIssueItem(
                  plantIssue: PlantIssue(
                    name: 'Leaf Spot Disease',
                    description: 'Common fungal infection',
                    image: 'assets/images/similar1.png',
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}

