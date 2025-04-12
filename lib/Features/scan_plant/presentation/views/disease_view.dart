import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mazraaty/Features/scan_plant/data/models/disease_details.dart';
import 'package:mazraaty/Features/scan_plant/presentation/views/widgets/disease_view_body.dart';
import 'package:mazraaty/constants.dart';

class DiseaseView extends StatelessWidget {
  const DiseaseView({
    super.key, 
    required this.details, 
    required this.imageBytes,
    this.imageUrl,
    this.source = 'scan', // Default source is scan
  });
  
  final DiseaseDetailsModel details;
  final Uint8List? imageBytes;
  final String? imageUrl;
  final String source; // 'scan' or 'history'
  
  @override
  Widget build(BuildContext context) {
    // Use provided imageUrl or fallback to disease images if needed
    final String? effectiveImageUrl = imageUrl ?? 
        (details.diseaseImages.isNotEmpty 
            ? '$baseUrl${details.diseaseImages.first.image}'
            : null);
    
    return SafeArea(
      child: Scaffold(
        body: DiseaseViewBody(
          details: details,
          imageBytes: imageBytes,
          imageUrl: effectiveImageUrl,
          source: source,
        ),
      ),
    );
  }
}
