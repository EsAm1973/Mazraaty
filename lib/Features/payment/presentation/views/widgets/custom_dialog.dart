import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String content;
  final String buttonText;
  final VoidCallback onPressed;

  const CustomDialog({
    super.key,
    required this.title,
    required this.content,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Text(
        title,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      content: Text(
        content,
        style: GoogleFonts.poppins(
          fontSize: 16,
        ),
      ),
      actions: [
        TextButton(
          onPressed: onPressed,
          child: Text(
            buttonText,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Colors.green,
            ),
          ),
        ),
      ],
    );
  }
} 