import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mazraaty/Features/scan_plant/data/models/disease_details.dart';
import 'package:mazraaty/Features/scan_plant/presentation/views/widgets/disease_view_body.dart';

class DiseaseView extends StatelessWidget {
  const DiseaseView({super.key, required this.details, required this.imageBytes});
  final DiseaseDetailsModel details;
  final Uint8List imageBytes;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: DiseaseViewBody(
          details: details,
          imageBytes: imageBytes,
        ),
      ),
    );
  }
}
