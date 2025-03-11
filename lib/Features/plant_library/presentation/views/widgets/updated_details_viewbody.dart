import 'package:flutter/material.dart';
import 'package:mazraaty/Core/widgets/sticky_headers_delegate.dart';
import 'package:mazraaty/Features/plant_library/presentation/views/widgets/updated_care_section.dart';
import 'package:mazraaty/Features/plant_library/presentation/views/widgets/updated_condition_section.dart';
import 'package:mazraaty/Features/plant_library/presentation/views/widgets/updated_description_text.dart';
import 'package:mazraaty/Features/plant_library/presentation/views/widgets/updated_plant_details.dart';
import 'package:mazraaty/Features/plant_library/presentation/views/widgets/updated_plant_title.dart';
import 'package:mazraaty/Features/plant_library/presentation/views/widgets/updated_requirement_section.dart';
import 'package:mazraaty/Features/plant_library/presentation/views/widgets/updated_scintification_classify.dart';
import 'package:mazraaty/Features/plant_library/presentation/views/widgets/updated_similar_list.dart';
import 'package:mazraaty/Features/plant_library/presentation/views/widgets/updated_soilinfo_card.dart';
import 'package:mazraaty/Features/plant_library/presentation/views/widgets/updated_tags_list.dart';
import 'package:mazraaty/Features/plant_library/presentation/views/widgets/updated_tempreature_card.dart';
import 'package:mazraaty/Features/plant_library/presentation/views/widgets/updated_topsection.dart';
import 'package:mazraaty/constants.dart';

class UpdatedDetailsViewbody extends StatelessWidget {
  const UpdatedDetailsViewbody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // هذا الجزء سيكون ثابتًا في الأعلى
          SliverPersistentHeader(
            pinned: true, // اجعل الهيدر ثابتًا عند التمرير
            floating: false,
            delegate: StickyHeaderDelegate(
              child: const UpdatedDetailsTopSection(),
              maxExtent: 300,
              minExtent: 300,
            ),
          ),

          // هذا الجزء سيكون قابلًا للتمرير
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 30),
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
                        )
                      ])),
            ]),
          ),
        ],
      ),
    );
  }
}
