import 'package:flutter/material.dart';
import 'package:mazraaty/Features/plant_library/presentation/views/widgets/updated_details_viewbody.dart';

class UpdatedDetailsView extends StatelessWidget {
  const UpdatedDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: Scaffold(
      body: UpdatedDetailsViewbody(),
    ));
  }
}
