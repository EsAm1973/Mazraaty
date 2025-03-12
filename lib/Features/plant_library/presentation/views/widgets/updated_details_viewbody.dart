import 'package:flutter/material.dart';
import 'package:mazraaty/Core/widgets/sticky_headers_delegate.dart';
import 'package:mazraaty/Features/plant_library/presentation/views/widgets/updated_care_section.dart';
import 'package:mazraaty/Features/plant_library/presentation/views/widgets/updated_condition_section.dart';
import 'package:mazraaty/Features/plant_library/presentation/views/widgets/updated_cultural_card.dart';
import 'package:mazraaty/Features/plant_library/presentation/views/widgets/updated_description_text.dart';
import 'package:mazraaty/Features/plant_library/presentation/views/widgets/updated_diseases.dart';
import 'package:mazraaty/Features/plant_library/presentation/views/widgets/updated_plant_details.dart';
import 'package:mazraaty/Features/plant_library/presentation/views/widgets/updated_plant_title.dart';
import 'package:mazraaty/Features/plant_library/presentation/views/widgets/updated_requirement_section.dart';
import 'package:mazraaty/Features/plant_library/presentation/views/widgets/updated_scintification_classify.dart';
import 'package:mazraaty/Features/plant_library/presentation/views/widgets/updated_similar_list.dart';
import 'package:mazraaty/Features/plant_library/presentation/views/widgets/updated_soilinfo_card.dart';
import 'package:mazraaty/Features/plant_library/presentation/views/widgets/updated_tags_list.dart';
import 'package:mazraaty/Features/plant_library/presentation/views/widgets/updated_tempreature_card.dart';
import 'package:mazraaty/Features/plant_library/presentation/views/widgets/updated_topsection.dart';
import 'package:mazraaty/Features/plant_library/presentation/views/widgets/updated_uses_card.dart';
import 'package:mazraaty/constants.dart';

class UpdatedDetailsViewbody extends StatelessWidget {
  const UpdatedDetailsViewbody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // هذا جزء ثابت
          SliverPersistentHeader(
            pinned: true, // هيدر ثابت
            floating: false,
            delegate: StickyHeaderDelegate(
              child: const UpdatedDetailsTopSection(),
              maxExtent: 300,
              minExtent: 300,
            ),
          ),

          // هذا قابل للتمرير
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),
                    const UpdatedDetailsPlantTitle(),
                    const SizedBox(height: 20),
                    const UpdatedDetailsTagsList(),
                    const SizedBox(height: 20),
                    const UpdatedDetailsPlantDetails(),
                    const SizedBox(height: 20),
                    const UpdatedDetailsSimilarPlantList(),
                    const SizedBox(height: 20),
                    const UpdatedDetailsPlantDescription(),
                    const SizedBox(height: 24),
                    const UpdatedDetailsScientificClassification(),
                    const SizedBox(height: 24),
                    const UpdatedDetailsCareSection(),
                    const SizedBox(height: 24),
                    const UpdatedDetailsConditionsSection(),
                    const SizedBox(height: 24),
                    const UpdatedDetailsSoilInfoCard(
                      soilType: 'Sandy',
                      drainage: 'Well Drained',
                      minPH: 5.0,
                      maxPH: 7.0,
                    ),
                    const SizedBox(height: 60),
                    const UpdatedDetailsTemperature(
                      minTemp: 10.0,
                      idealMin: 35.0,
                      idealMax: 45.0,
                      maxTemp: 50.0,
                    ),
                    const SizedBox(height: 24),
                    UpdatedDetailsRequirementsSection(
                      requirements: requirementsData,
                    ),
                    const SizedBox(height: 24),
                    const UpdatedDetailsDiseases(
                      pests: ["Scale insects", "Mealybugs", "Spider mites"],
                      diseases: ["Stem rot", "Root rot", "Leaf spot disease"],
                    ),
                    const SizedBox(height: 24),
                    const UpdatedDetailsUsesCard(
                      iconPath: 'assets/images/leaf.png',
                      title: 'Symbolism',
                      description:
                          'Mint (Mentha) is a versatile herb widely used for its refreshing flavor and medicinal properties. It is commonly used in cooking to add flavor to dishes, teas, and beverages. In herbal medicine, mint helps with digestion, relieves headaches, and soothes cold symptoms.',
                    ),
                    const SizedBox(height: 24),
                    const UpdatedDetailsCulturalCard(
                      iconPath: 'assets/images/leaf.png',
                      title: 'Symbolism',
                      description:
                          'Mint is widely associated with freshness, both in terms of its flavor and aroma. It symbolizes rejuvenation, renewal, and a fresh start. Its cooling properties also make it a symbol of vitality and invigoration.',
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
