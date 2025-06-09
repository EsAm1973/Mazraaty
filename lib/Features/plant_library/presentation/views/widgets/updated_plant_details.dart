import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UpdatedDetailsPlantDetails extends StatelessWidget {
  const UpdatedDetailsPlantDetails(
      {super.key,
      required this.botanicalName,
      required this.scientificName,
      required this.alsoKnownAs});
  final String botanicalName;
  final String scientificName;
  final String alsoKnownAs;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildRichText("Botanical Name: ", botanicalName),
        const SizedBox(height: 8),
        _buildRichText("Scientific Name: ", scientificName),
        const SizedBox(height: 12),
        _buildRichText(
          "Also known as: ",
          alsoKnownAs,
          isItalic: false,
          isBold: true,
        ),
      ],
    );
  }

  Widget _buildRichText(String label, String value,
      {bool isItalic = true, bool isBold = false}) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: label,
            style: GoogleFonts.montserrat(
              fontSize: 18,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
          TextSpan(
              text: value,
              style: GoogleFonts.montserrat(
                fontSize: 16,
                color: Colors.black,
                fontWeight: isBold ? FontWeight.bold : FontWeight.bold,
                fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
              )),
        ],
      ),
    );
  }
}
