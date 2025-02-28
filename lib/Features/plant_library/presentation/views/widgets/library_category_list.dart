import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mazraaty/Core/utils/styles.dart';
import 'package:mazraaty/Features/plant_library/presentation/manager/LibraryCubit/library_cubit.dart';
import 'package:mazraaty/constants.dart';

class LibraryCategoriesList extends StatelessWidget {
  const LibraryCategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LibraryCubit, LibraryState>(
      builder: (context, state) {
        if (state is LibrarySuccess) {
          return SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: state.categories.length,
              itemBuilder: (context, index) {
                final isSelected = index == state.selectedIndex;
                return GestureDetector(
                  onTap: () => context
                      .read<LibraryCubit>()
                      .selectCategory(index, state.categories),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: IntrinsicWidth(
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? kMainColor : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          state.categories[index].name,
                          style: Styles.textStyle18.copyWith(
                            color: isSelected ? Colors.white : kMainColor,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        } else if (state is LibraryError) {
          return Center(child: Text(state.errorMessage));
        } else if (state is LibraryLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return const Center(child: Text('Unknown Error'));
        }
      },
    );
  }
}
