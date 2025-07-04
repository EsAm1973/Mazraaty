import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mazraaty/Core/utils/app_router.dart';
import 'package:mazraaty/Core/utils/styles.dart';
import 'package:mazraaty/Features/history/data/models/history_model.dart';
import 'package:mazraaty/Features/scan_plant/data/models/disease_details.dart';
import 'package:mazraaty/constants.dart';

class HistoryListItem extends StatelessWidget {
  const HistoryListItem({super.key, required this.disease});
  final HistoryDisease disease;

  @override
  Widget build(BuildContext context) {
    final String? imageUrl = disease.imageHistory;
    print('Image URL: $imageUrl');
    return GestureDetector(
      onTap: () {
        // Create a DiseaseDetailsModel from the history disease
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
              diseaseImages: disease.diseaseImages,
            ),
            'imageBytes': null,
            'imageUrl': imageUrl,
            'source': 'history',
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
              child: imageUrl != null
                  ? CachedNetworkImage(
                      imageUrl: imageUrl,
                      width: 110,
                      height: 110,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        width: 110,
                        height: 110,
                        color: Colors.grey.shade200,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        width: 110,
                        height: 110,
                        color: Colors.grey.shade300,
                        child: const Center(
                          child: Icon(Icons.error, color: Colors.red),
                        ),
                      ),
                    )
                  : Container(
                      width: 110,
                      height: 110,
                      color: Colors.grey.shade300,
                      child: const Center(
                        child: Icon(Icons.image_not_supported),
                      ),
                    ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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
                  if (disease.repetitions > 0)
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        'Saved ${disease.repetitions} times',
                        style: Styles.textStyle13.copyWith(
                          color: kMainColor.withOpacity(0.7),
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
