import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UpdatedDetailsTagItem extends StatelessWidget {
  const UpdatedDetailsTagItem({super.key, required this.tag});
  final String tag;
  @override
  Widget build(BuildContext context) {
    // Check if the tag contains "Toxic" (case-insensitive)
    bool isToxic = tag.toLowerCase().contains('toxic');

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: isToxic ? Colors.red.shade50 : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
        //border: isToxic ? Border.all(color: Colors.red.shade300, width: 1) : null,
      ),
      child: Text(
        tag,
        style: GoogleFonts.montserrat(
          fontSize: 16,
          color: isToxic ? Colors.red.shade700 : Colors.black,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
