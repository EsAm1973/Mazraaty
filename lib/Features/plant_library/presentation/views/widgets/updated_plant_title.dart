import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UpdatedDetailsPlantTitle extends StatelessWidget {
  const UpdatedDetailsPlantTitle({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
              text: title,
              style: GoogleFonts.montserrat(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              )),
        ],
      ),
      maxLines: 2,
      softWrap: true,
    );
  }
}
