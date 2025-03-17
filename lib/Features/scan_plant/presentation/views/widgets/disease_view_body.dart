import 'package:flutter/material.dart';
import 'package:mazraaty/Core/widgets/sticky_headers_delegate.dart';
import 'package:mazraaty/Features/scan_plant/presentation/views/widgets/disease_top_image.dart';

class DiseaseViewBody extends StatelessWidget {
  const DiseaseViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          floating: false,
          delegate: StickyHeaderDelegate(
            child: const DiseaseTopImage(),
            maxExtent: 300,
            minExtent: 300,
          ),
        )
      ],
    );
  }
}