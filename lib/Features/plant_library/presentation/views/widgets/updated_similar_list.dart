import 'package:flutter/material.dart';
import 'package:mazraaty/Core/utils/styles.dart';
import 'package:mazraaty/Features/plant_library/presentation/views/widgets/updated_similarlist_item.dart';
import 'package:mazraaty/constants.dart';

class UpdatedDetailsSimilarPlantList extends StatelessWidget {
  const UpdatedDetailsSimilarPlantList({super.key, required this.plantName});
  final String plantName;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Similar Plant of $plantName",
          style: Styles.textStyle23.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 160, // ارتفاع الـ ListView
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: similarPlants.length,
            itemBuilder: (context, index) {
              final plant = similarPlants[index];
              return UpdatedDetailsSimilarItem(
                imagePath: plant['image']!,
                name: plant['name']!,
              );
            },
          ),
        ),
      ],
    );
  }
}
