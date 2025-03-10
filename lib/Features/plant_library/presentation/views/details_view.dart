import 'package:flutter/material.dart';
import 'package:mazraaty/Features/plant_library/data/models/plant.dart';
import 'package:mazraaty/Features/plant_library/presentation/views/widgets/details_view_body.dart';
import 'package:mazraaty/constants.dart';

class PlantDetailsView extends StatelessWidget {
  const PlantDetailsView({super.key, required this.plant});
  final Plant plant;
  @override
  Widget build(BuildContext context) {
    return  const SafeArea(
        child: Scaffold(
      backgroundColor: kScaffoldColor,
      body: DetailsViewBody(),
    ));
  }
}
