import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mazraaty/constants.dart';

class TitlePaymentMethods extends StatelessWidget {
  const TitlePaymentMethods({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Text(
        'Payment Methods',
        style: GoogleFonts.poppins(
          fontSize: 30,
          color: kMainColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
