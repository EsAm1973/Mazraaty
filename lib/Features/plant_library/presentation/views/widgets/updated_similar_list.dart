import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mazraaty/Core/utils/styles.dart';
import 'package:mazraaty/Features/plant_library/data/models/plant.dart';
import 'package:mazraaty/Features/plant_library/presentation/views/widgets/updated_similarlist_item.dart';
import 'package:mazraaty/constants.dart';

class UpdatedDetailsSimilarPlantList extends StatelessWidget {
  const UpdatedDetailsSimilarPlantList({
    super.key,
    required this.similarPlants,
    required this.plantName,
  });

  final List<SimilarPlant> similarPlants;
  final String plantName;

  @override
  Widget build(BuildContext context) {
    // حالة عدم وجود نباتات مشابهة
    if (similarPlants.isEmpty) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.local_florist_outlined,
              size: 70,
              color: kMainColor,
            ),
            SizedBox(height: 12),
            Text(
              "No Similar Plants Found",
              style: Styles.textStyle20,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    // الحالة الافتراضية عند وجود بيانات
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Similar Plants to $plantName",
          style: GoogleFonts.montserrat(
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 160,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: similarPlants.length,
            itemBuilder: (context, index) {
              final plant = similarPlants[index];
              return UpdatedDetailsSimilarItem(
                imagePath: plant.image,
                name: plant.name,
              );
            },
          ),
        ),
      ],
    );
  }
}
