import 'package:flutter/material.dart';
import 'package:mazraaty/Core/utils/styles.dart';
import 'package:mazraaty/constants.dart';

class NavigationTabBar extends StatelessWidget {
  final int currentPage;
  final Function(int) onTabSelected;

  const NavigationTabBar({
    super.key,
    required this.currentPage,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            spreadRadius: 1,
          ),
        ],
        border: Border.all(
          color: Colors.white.withOpacity(0.8),
          width: 1.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          children: [
            _buildNavTab(0, 'List', Icons.format_list_bulleted_rounded),
            _buildNavTab(1, 'Bar Chart', Icons.bar_chart_rounded),
            _buildNavTab(2, 'Pie Chart', Icons.pie_chart_rounded),
          ],
        ),
      ),
    );
  }

  Widget _buildNavTab(int index, String label, IconData icon) {
    final bool isSelected = currentPage == index;
    
    return Expanded(
      child: GestureDetector(
        onTap: () => onTabSelected(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100), // Faster animation
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? kMainColor : Colors.transparent,
            borderRadius: BorderRadius.circular(25),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: kMainColor.withOpacity(0.3),
                      blurRadius: 8,
                      spreadRadius: 0,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
            gradient: isSelected
                ? const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      kMainColor,
                      Color.fromARGB(255, 76, 141, 53),
                    ],
                  )
                : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isSelected ? Colors.white : kMainColor.withOpacity(0.7),
                size: 20,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: Styles.textStyle12.copyWith(
                  color: isSelected ? Colors.white : kMainColor.withOpacity(0.7),
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
