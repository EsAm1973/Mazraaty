import 'package:flutter/material.dart';
import 'package:mazraaty/Core/utils/styles.dart';
import 'package:mazraaty/constants.dart';

class LibraryCategoriesList extends StatefulWidget {
  const LibraryCategoriesList({super.key});

  @override
  State<LibraryCategoriesList> createState() => _LibraryCategoriesListState();
}

class _LibraryCategoriesListState extends State<LibraryCategoriesList> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40, // Ensuring a fixed height for the list
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: 10, // Replace this with fetched API data length
        itemBuilder: (context, index) {
          final isSelected = index == _selectedIndex;
          final categoryName =
              index == 0 ? 'Fruit' : 'Agriculturalture'; // Example text

          return GestureDetector(
            onTap: () => setState(() => _selectedIndex = index),
            child: Padding(
              padding: const EdgeInsets.only(right: 15),
              child: IntrinsicWidth(
                // Allows container to take only as much space as needed
                child: Container(
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? kMainColor : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    categoryName,
                    style: Styles.textStyle18.copyWith(
                      color: isSelected ? Colors.white : kMainColor,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
