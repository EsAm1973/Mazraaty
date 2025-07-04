import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mazraaty/Features/plant_library/presentation/manager/LibraryCubit/library_cubit.dart';
import 'package:mazraaty/constants.dart';

class LibraryCategoriesList extends StatelessWidget {
  const LibraryCategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocBuilder<LibraryCubit, LibraryState>(
      builder: (context, state) {
        if (state is LibrarySuccess) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 4, bottom: 12),
                child: Text(
                  'Categories',
                  style: GoogleFonts.montserrat(
                    fontSize: screenWidth * 0.045,
                    fontWeight: FontWeight.w600,
                    color: kMainColor,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.06,
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
                      child: Container(
                        margin: EdgeInsets.only(
                          right: screenWidth * 0.03,
                          bottom: 2,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.05,
                          vertical: screenHeight * 0.012,
                        ),
                        decoration: BoxDecoration(
                          gradient: isSelected
                              ? LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    kMainColor,
                                    kMainColor.withValues(alpha: 0.8),
                                  ],
                                )
                              : null,
                          color: isSelected ? null : Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: isSelected
                                ? Colors.transparent
                                : kMainColor.withValues(alpha: 0.3),
                            width: 1.5,
                          ),
                          boxShadow: [
                            if (isSelected)
                              BoxShadow(
                                color: kMainColor.withValues(alpha: 0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            state.categories[index].name,
                            style: GoogleFonts.montserrat(
                              fontSize: 16,
                              color: isSelected ? Colors.white : kMainColor,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w500,
                              letterSpacing: 0.2,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        } else if (state is LibraryError) {
          return _buildErrorState(state.errorMessage, screenWidth);
        } else if (state is LibraryLoading) {
          return _buildLoadingState(screenHeight);
        } else {
          return _buildErrorState('Unknown Error', screenWidth);
        }
      },
    );
  }

  Widget _buildLoadingState(double screenHeight) {
    return SizedBox(
      height: screenHeight * 0.08,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: 4,
        itemBuilder: (context, index) => Container(
          margin: const EdgeInsets.only(right: 12),
          width: 80,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(25),
          ),
          child: const Center(
            child: SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: kMainColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildErrorState(String message, double screenWidth) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red[200]!),
      ),
      child: Row(
        children: [
          Icon(
            Icons.error_outline,
            color: Colors.red[600],
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: GoogleFonts.montserrat(
                color: Colors.red[700],
                fontSize: screenWidth * 0.035,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
