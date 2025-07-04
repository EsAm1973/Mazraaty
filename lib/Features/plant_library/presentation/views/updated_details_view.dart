import 'package:flutter/material.dart';
import 'package:mazraaty/Features/plant_library/data/models/plant.dart';
import 'package:mazraaty/Features/plant_library/presentation/views/widgets/updated_details_viewbody.dart';

class UpdatedDetailsView extends StatelessWidget {
  const UpdatedDetailsView({super.key, required this.plant});
  final Plant plant;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: UpdatedDetailsViewbody(
        plant: plant,
      ),
    ));
  }
}
