import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mazraaty/Core/utils/styles.dart';

class UpdatedDetailsScientificClassification extends StatelessWidget {
  const UpdatedDetailsScientificClassification(
      {super.key,
      required this.genus,
      required this.family,
      required this.order,
      required this.grouping,
      required this.phylum});
  final String genus;
  final String family;
  final String order;
  final String grouping;
  final String phylum;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Scientific classification",
          style: Styles.textStyle23.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Column(
          children: [
            _buildClassificationRow("Genus", genus),
            _buildClassificationRow("Family", family),
            _buildClassificationRow("Order", order),
            _buildClassificationRow("Class", grouping),
            _buildClassificationRow(
              "Phylum",
              phylum,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildClassificationRow(
    String label,
    String value,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.montserrat(fontSize: 16),
          ),
          Text(value,
              style: GoogleFonts.montserrat(
                  fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
