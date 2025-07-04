import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mazraaty/Core/utils/styles.dart';
import 'package:mazraaty/Features/plant_library/presentation/manager/LibraryCubit/library_cubit.dart';
import 'package:mazraaty/constants.dart';

class LibrarySearchTextFeild extends StatefulWidget {
  const LibrarySearchTextFeild({super.key});

  @override
  State<LibrarySearchTextFeild> createState() => _LibrarySearchTextFeildState();
}

class _LibrarySearchTextFeildState extends State<LibrarySearchTextFeild>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.02,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white,
                  Colors.white.withValues(alpha: 0.95),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: kMainColor.withValues(alpha: 0.15),
                  spreadRadius: 0,
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  spreadRadius: 0,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
              border: Border.all(
                color: _isFocused
                    ? kMainColor.withValues(alpha: 0.3)
                    : Colors.transparent,
                width: 1.5,
              ),
            ),
            child: TextField(
              onChanged: (value) {
                context.read<LibraryCubit>().searchPlants(value);
              },
              onTap: () {
                setState(() => _isFocused = true);
                _animationController.forward();
              },
              onTapOutside: (event) {
                setState(() => _isFocused = false);
                _animationController.reverse();
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                filled: true,
                fillColor: Colors.transparent,
                hintText: 'Search plants...',
                hintStyle: Styles.textStyle16.copyWith(
                  color: Colors.grey[400],
                  fontWeight: FontWeight.w400,
                ),
                prefixIcon: Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: kMainColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.search_rounded,
                    color: kMainColor,
                    size: screenWidth * 0.06,
                  ),
                ),
                suffixIcon: _isFocused
                    ? Container(
                        margin: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.tune_rounded,
                          color: Colors.grey[600],
                          size: screenWidth * 0.05,
                        ),
                      )
                    : null,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 18,
                ),
              ),
              style: Styles.textStyle16.copyWith(
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      },
    );
  }
}
