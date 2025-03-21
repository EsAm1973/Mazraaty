import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mazraaty/Core/utils/app_router.dart';
import 'package:mazraaty/Core/utils/styles.dart';
import 'package:mazraaty/Features/scan_plant/data/models/disease_details.dart';
import 'package:mazraaty/constants.dart';

class DiseaseBottomSheetWidget extends StatelessWidget {
  final DiseaseDetailsModel details;
  final double confidance;
  final Uint8List imageBytes;

  const DiseaseBottomSheetWidget(
      {super.key,
      required this.details,
      required this.imageBytes,
      required this.confidance});

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.max, // Changed to max
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              details.originName,
              style: Styles.textStyle30
                  .copyWith(fontWeight: FontWeight.bold, color: kMainColor),
            ),
            const SizedBox(height: 8),
            Text(
              'Confidence: ${(confidance * 100).toStringAsFixed(1)}%',
              style: Styles.textStyle18.copyWith(color: Colors.black54),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: Scrollbar(
                thickness: 6,
                radius: const Radius.circular(2),
                thumbVisibility: true,
                interactive: true,
                controller: _scrollController,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: Text(
                      details.description,
                      style: Styles.textStyle15.copyWith(color: Colors.black54),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10), // Replaced Spacer with SizedBox
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(12),
                  backgroundColor: kMainColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  GoRouter.of(context).push(
                    AppRouter.kDiseaseView,
                    extra: {'details': details, 'imageBytes': imageBytes},
                  );
                },
                child: const Text(
                  'Read More',
                  style: Styles.textStyle20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
