import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mazraaty/Core/utils/styles.dart';
import 'package:mazraaty/Core/widgets/custom_button.dart';
import 'package:mazraaty/Features/home/data/models/plant_garden.dart';
import 'package:mazraaty/Features/home/presentation/views/widgets/home_myplant_item.dart';

class HomeMyPlantList extends StatelessWidget {
  const HomeMyPlantList(
      {super.key, required this.plant, this.onAddNewPlantTap});
  final PlantGarden plant;
  final VoidCallback? onAddNewPlantTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'My Plants',
              style: GoogleFonts.montserrat(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextButton(
              onPressed: () {
                // Navigate to all plants view
              },
              child: Text(
                'See All',
                style: Styles.textStyle15.copyWith(
                  color: Colors.green[700],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        GridView.builder(
          //padding: const EdgeInsets.symmetric(horizontal: 16),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.70,
          ),
          itemCount: 4, // Show only first 4 plants
          itemBuilder: (context, index) {
            return HomeMyPlantItem(plant: plant);
          },
        ),
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CustomElevatedButton(
            text: 'Add New Plant',
            onPressed: onAddNewPlantTap,
          ),
        )
      ],
    );
  }
}
