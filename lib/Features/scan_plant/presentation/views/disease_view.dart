import 'package:flutter/material.dart';
import 'package:mazraaty/Features/scan_plant/presentation/views/widgets/disease_view_body.dart';

class DiseaseView extends StatelessWidget {
  const DiseaseView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: DiseaseViewBody(),
      ),
    );
  }
}
