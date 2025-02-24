import 'package:flutter/material.dart';
import 'package:mazraaty/Features/plant_library/presentation/views/widgets/library_category_list.dart';
import 'package:mazraaty/Features/plant_library/presentation/views/widgets/library_plants_gridview.dart';
import 'package:mazraaty/Features/plant_library/presentation/views/widgets/library_search_textfeild.dart';

class LibraryViewBody extends StatelessWidget {
  const LibraryViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 29, vertical: 15),
        child: Column(
          children: [
            LibrarySearchTextFeild(),
            SizedBox(
              height: 22,
            ),
            LibraryCategoriesList(),
            SizedBox(
              height: 18,
            ),
            Expanded(child: LibraryPlantGrid()),
          ],
        ),
      ),
    );
  }
}
