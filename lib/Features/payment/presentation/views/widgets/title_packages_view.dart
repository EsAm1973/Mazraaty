import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mazraaty/constants.dart';

class TitlePackageViews extends StatelessWidget {
  const TitlePackageViews({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Text(
        'Choose your plan',
        style: GoogleFonts.poppins(
          fontSize: 30,
          color: kMainColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
