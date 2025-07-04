import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UpdatedDetailsConditionsSection extends StatelessWidget {
  const UpdatedDetailsConditionsSection(
      {super.key, required this.sunLight, required this.hardnessZone});
  final String sunLight;
  final String hardnessZone;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Conditions",
          style: GoogleFonts.montserrat(
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            _buildConditionCard(
              image: 'assets/images/sun.png',
              title: "Sunlight",
              value: sunLight,
            ),
            const SizedBox(width: 12),
            _buildConditionCard(
              image: 'assets/images/location.png',
              title: "Hardness",
              value: hardnessZone,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildConditionCard({
    required String image,
    required String title,
    required String value,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(image, width: 30, height: 30),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: GoogleFonts.montserrat(
                        fontSize: 15, color: Colors.black54),
                  ),
                  Text(
                    value,
                    style: GoogleFonts.montserrat(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
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
