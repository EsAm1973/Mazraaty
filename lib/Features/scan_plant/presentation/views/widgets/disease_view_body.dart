import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mazraaty/Core/widgets/sticky_headers_delegate.dart';
import 'package:mazraaty/Features/scan_plant/presentation/views/widgets/disease_description.dart';
import 'package:mazraaty/Features/scan_plant/presentation/views/widgets/disease_scientific_names.dart';
import 'package:mazraaty/Features/scan_plant/presentation/views/widgets/disease_similar_list.dart';
import 'package:mazraaty/Features/scan_plant/presentation/views/widgets/disease_solutions.dart';
import 'package:mazraaty/Features/scan_plant/presentation/views/widgets/disease_symptoms.dart';
import 'package:mazraaty/Features/scan_plant/presentation/views/widgets/disease_top_image.dart';

class DiseaseViewBody extends StatelessWidget {
  const DiseaseViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          floating: false,
          delegate: StickyHeaderDelegate(
            child: const DiseaseTopImage(),
            maxExtent: 300,
            minExtent: 300,
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Mint Rust',
                      style: GoogleFonts.montserrat(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const DiseaseScientificNames(
                      diseaseName: 'Mint Rust',
                      scientificName: 'Puccinia menthae',
                      alsoKnownAs: '“Puccinia Rust” , “Rust Disease”',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const DiseaseDescription(
                      description:
                          'Mint Rust is a fungal disease that primarily affects plants in the Mint family (Lamiaceae), such as peppermint (Mentha piperita) and spearmint (Mentha spicata). The disease manifests as small, orange, yellow, or reddish pustules on the undersides of the leaves, which can eventually lead to leaf drop, reduced vigor, and plant death if left untreated.',
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    const DiseaseSimilarList(),
                    const SizedBox(
                      height: 24,
                    ),
                    SymptomsScreen(),
                    const SizedBox(
                      height: 24,
                    ),
                    DiseaseSoluations(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}