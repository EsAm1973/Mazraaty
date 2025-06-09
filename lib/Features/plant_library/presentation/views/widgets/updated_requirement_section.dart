import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mazraaty/constants.dart';

class UpdatedDetailsRequirementsSection extends StatelessWidget {
  final String water;
  final String repotting;
  final String fertilizer;
  final String misting;
  final String pruning;

  const UpdatedDetailsRequirementsSection(
      {super.key,
      required this.water,
      required this.repotting,
      required this.fertilizer,
      required this.misting,
      required this.pruning});

  @override
  Widget build(BuildContext context) {
    final List<RequirementItem> requirements = [
      RequirementItem(
        title: "Water",
        description: water, // الوصف من ال API
        iconPath: "assets/images/droplet.png",
      ),
      RequirementItem(
        title: "Repotting",
        description: repotting,
        iconPath: "assets/images/plant-02.png",
      ),
      RequirementItem(
        title: "Fertilizer",
        description: fertilizer,
        iconPath: "assets/images/soil-moisture-field.png",
      ),
      RequirementItem(
        title: "Misting",
        description: misting,
        iconPath: "assets/images/water-energy.png",
      ),
      RequirementItem(
        title: "Pruning",
        description: pruning,
        iconPath: "assets/images/scissor.png",
      ),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Requirements",
          style: GoogleFonts.montserrat(
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: requirements
              .map((item) => _buildRequirementCard(context, item))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildRequirementCard(BuildContext context, RequirementItem item) {
    return Container(
      width: (MediaQuery.of(context).size.width - 48) / 2,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ConstrainedBox(
        constraints:
            const BoxConstraints(minHeight: 80), // تعديل الارتفاع الأدنى
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              item.iconPath,
              width: 24,
              height: 24,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    item.title,
                    style: GoogleFonts.montserrat(fontSize: 15),
                  ),
                  Text(
                    item.description,
                    style: GoogleFonts.montserrat(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
