import 'package:flutter/material.dart';
import 'package:mazraaty/Core/widgets/sticky_headers_delegate.dart';
import 'package:mazraaty/Features/plant_library/data/models/plant.dart';
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

class UpdatedDetailsViewbody extends StatelessWidget {
  const UpdatedDetailsViewbody({super.key, required this.plant});
  final Plant plant;
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
              child: UpdatedDetailsTopSection(
                imageUrl: plant.headerImage,
              ),
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
                    UpdatedDetailsPlantTitle(
                      title: plant.name,
                    ),
                    const SizedBox(height: 20),
                    UpdatedDetailsTagsList(
                      tags: plant.tags,
                    ),
                    const SizedBox(height: 20),
                    UpdatedDetailsPlantDetails(
                      botanicalName: plant.botanicalName,
                      scientificName: plant.scientificName,
                      alsoKnownAs: plant.alsoKnownAs,
                    ),
                    const SizedBox(height: 20),
                    UpdatedDetailsSimilarPlantList(
                      plantName: plant.name,
                    ),
                    const SizedBox(height: 20),
                    UpdatedDetailsPlantDescription(
                        description: plant.description),
                    const SizedBox(height: 24),
                    UpdatedDetailsScientificClassification(
                      genus: plant.genus,
                      family: plant.family,
                      order: plant.order,
                      grouping: plant.group,
                      phylum: plant.phylum,
                    ),
                    const SizedBox(height: 24),
                    UpdatedDetailsCareSection(
                      toughness: plant.toughness,
                      maintance: plant.maintenance,
                    ),
                    const SizedBox(height: 24),
                    UpdatedDetailsConditionsSection(
                      sunLight: plant.sunlight,
                      hardnessZone: plant.hardnessZone,
                    ),
                    const SizedBox(height: 24),
                    UpdatedDetailsSoilInfoCard(
                      soilType: plant.type,
                      drainage: plant.drainage,
                      minPH: plant.minPh,
                      maxPH: plant.maxPh,
                    ),
                    const SizedBox(height: 60),
                    UpdatedDetailsTemperature(
                      minTemp: plant.minTp,
                      idealMin: plant.idealMinTp,
                      idealMax: plant.idealMaxTp,
                      maxTemp: plant.maxTp,
                    ),
                    const SizedBox(height: 24),
                    UpdatedDetailsRequirementsSection(
                      water: plant.water,
                      repotting: plant.repotting,
                      fertilizer: plant.fertilizer,
                      misting: plant.misting,
                      pruning: plant.pruning,
                    ),
                    const SizedBox(height: 24),
                    UpdatedDetailsDiseases(
                      pests: plant.pests,
                      diseases: plant.diseases,
                    ),
                    const SizedBox(height: 24),
                    UpdatedDetailsUsesCard(
                      iconPath: 'assets/images/leaf.png',
                      title: 'Symbolism',
                      description: plant.uses,
                    ),
                    const SizedBox(height: 24),
                    UpdatedDetailsCulturalCard(
                      iconPath: 'assets/images/leaf.png',
                      title: 'Symbolism',
                      description: plant.culture,
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
