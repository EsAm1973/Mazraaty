import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mazraaty/Core/widgets/sticky_headers_delegate.dart';
import 'package:mazraaty/Features/scan_plant/data/models/disease_details.dart';
import 'package:mazraaty/Features/scan_plant/presentation/views/widgets/disease_description.dart';
import 'package:mazraaty/Features/scan_plant/presentation/views/widgets/disease_home_remedies.dart';
import 'package:mazraaty/Features/scan_plant/presentation/views/widgets/disease_prevention.dart';
import 'package:mazraaty/Features/scan_plant/presentation/views/widgets/disease_scientific_names.dart';
import 'package:mazraaty/Features/scan_plant/presentation/views/widgets/disease_similar_list.dart';
import 'package:mazraaty/Features/scan_plant/presentation/views/widgets/disease_solutions.dart';
import 'package:mazraaty/Features/scan_plant/presentation/views/widgets/disease_symptoms.dart';
import 'package:mazraaty/Features/scan_plant/presentation/views/widgets/disease_top_image.dart';

class DiseaseViewBody extends StatelessWidget {
  const DiseaseViewBody({
    super.key, 
    required this.details, 
    required this.imageBytes, 
    this.imageUrl,
    this.source = 'scan', // Default is scan
  });
  
  final DiseaseDetailsModel details;
  final Uint8List? imageBytes;
  final String? imageUrl;
  final String source; // 'scan' or 'history'
  
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          pinned: false,
          floating: false,
          delegate: StickyHeaderDelegate(
            child: DiseaseTopImage(
              image: imageBytes ?? Uint8List(0), // Provide empty list if null
              disease: details,
              imageUrl: imageUrl,
              source: source,
            ),
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
                      details.originName,
                      style: GoogleFonts.montserrat(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    DiseaseScientificNames(
                      diseaseName: details.name,
                      scientificName: details.scientificName,
                      alsoKnownAs: details.alsoKnowAs,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    DiseaseDescription(
                      description: details.description,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    const DiseaseSimilarList(),
                    const SizedBox(
                      height: 24,
                    ),
                    SymptomsScreen(
                      symptoms: details.symptoms,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    DiseaseSoluations(
                      solutions: details.solutions,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    DiseaseHomeRemedies(remedies: details.homeRemedys),
                    const SizedBox(
                      height: 24,
                    ),
                    DiseasePrevention(
                      preventions: details.preventions,
                    ),
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
