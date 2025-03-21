import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mazraaty/Core/utils/app_router.dart';
import 'package:mazraaty/Core/utils/styles.dart';
import 'package:mazraaty/Features/history/data/models/history_model.dart';
import 'package:mazraaty/Features/scan_plant/data/models/disease_details.dart';
import 'package:mazraaty/constants.dart';

import 'dart:io';

class HistoryListItem extends StatelessWidget {
  const HistoryListItem({super.key, required this.disease});
  final HistoryDisease disease;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final imageBytes = await File(disease.imagePath).readAsBytes();
        GoRouter.of(context).push(
          AppRouter.kDiseaseView,
          extra: {
            'details': DiseaseDetailsModel(
                id: disease.diseaseId,
                name: disease.name,
                originName: disease.originName,
                scientificName: disease.scientificName,
                alsoKnowAs: disease.alsoKnowAs,
                typeDisease: disease.typeDisease,
                description: disease.description,
                symptoms: disease.symptoms,
                solutions: disease.solutions,
                preventions: disease.preventions,
                homeRemedys: disease.homeRemedys,
                diseaseImages: disease.diseaseImages),
            'imageBytes': imageBytes
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: kMainColor.withOpacity(0.30),
        ),
        padding: const EdgeInsets.only(right: 10),
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
              child: Image.file(
                File(disease.imagePath),
                width: 110,
                height: 110,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    disease.originName,
                    style: Styles.textStyle16.copyWith(
                      color: kMainColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    disease.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Styles.textStyle15.copyWith(
                      color: kMainColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 5),
            GestureDetector(
              onTap: () {
                // هنا يمكن إضافة حدث الحذف أو أي إجراء آخر
              },
              child: const Icon(
                Icons.cancel,
                color: kMainColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
