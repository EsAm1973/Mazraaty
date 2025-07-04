import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mazraaty/Features/scan_plant/data/models/home_remedy.dart';
import 'package:mazraaty/Features/scan_plant/presentation/views/widgets/disease_remedies_item.dart';
import 'package:mazraaty/constants.dart';
class DiseaseHomeRemedies extends StatelessWidget {
  final List<HomeRemedy> remedies;

  const DiseaseHomeRemedies({super.key, required this.remedies});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.grey.shade50,
            Colors.white,
          ],
        ),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header Section
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: kMainColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: const Icon(
                    Icons.home_repair_service_outlined,
                    color: kMainColor,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Home Remedies",
                        style: GoogleFonts.cairo(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade800,
                        ),
                      ),
                      Text(
                        "${remedies.length} remedies available",
                        style: GoogleFonts.cairo(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Remedies List
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
            itemCount: remedies.length,
            itemBuilder: (context, index) {
              return AnimatedContainer(
                duration: Duration(milliseconds: 300 + (index * 100)),
                child: RemedyItem(
                  number: index + 1,
                  title: remedies[index].title,
                  description: remedies[index].description,
                  index: index,
                  isLast: index == remedies.length - 1,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}