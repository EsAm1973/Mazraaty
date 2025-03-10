import 'package:flutter/material.dart';
import 'package:mazraaty/Features/plant_library/presentation/views/widgets/details_appbar.dart';
import 'package:mazraaty/Features/plant_library/presentation/views/widgets/details_plant_description.dart';
import 'package:mazraaty/Features/plant_library/presentation/views/widgets/details_plantdetails.dart';

class DetailsViewBody extends StatelessWidget {
  const DetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final halfHeight = constraints.maxHeight / 2;
      return Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: halfHeight,
                child: const SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DetailsCustomAppBar(),
                      DetailsOfPlant(),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: halfHeight,
                child: const DetailsDescriptionPlant(),
              ),
            ],
          ),
          Positioned(
            right: 20,
            top: halfHeight - 50,
            child: Image.asset(
              'assets/images/tomato_test.png',
              width: 120,
              height: 120,
            ),
          )
        ],
      );
    });
  }
}
