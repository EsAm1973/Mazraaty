import 'package:flutter/material.dart';
import 'package:mazraaty/Features/plant_library/presentation/views/widgets/library_view_body.dart';
import 'package:mazraaty/constants.dart';

class LibraryView extends StatelessWidget {
  const LibraryView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: Scaffold(
      backgroundColor: kScaffoldColor,
      body: LibraryViewBody(),
    ));
  }
}
