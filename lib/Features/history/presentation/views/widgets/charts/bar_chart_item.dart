import 'package:flutter/material.dart';
import 'package:mazraaty/Core/utils/styles.dart';
import 'package:mazraaty/Features/history/data/models/history_model.dart';
import 'package:mazraaty/Features/history/presentation/views/widgets/common/info_row.dart';
import 'package:mazraaty/constants.dart';

class BarChartItem extends StatelessWidget {
  final HistoryDisease disease;
  final double percentage;
  final int index;
  final int rank;
  final Color rankColor;
  final int touchedIndex;
  final Animation<double> animation;
  final Function(int) onTap;

  const BarChartItem({
    super.key,
    required this.disease,
    required this.percentage,
    required this.index,
    required this.rank,
    required this.rankColor,
    required this.touchedIndex,
    required this.animation,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = touchedIndex == index;
    
    return GestureDetector(
      onTap: () => onTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: isSelected ? 0 : 8.0,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: rankColor.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ]
              : [],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Disease name and count with rank
                  Row(
                    children: [
                      // Rank indicator
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: rankColor.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '$rank',
                            style: Styles.textStyle15.copyWith(
                              color: rankColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Disease name
                      Expanded(
                        child: Text(
                          disease.originName,
                          style: Styles.textStyle16.copyWith(
                            color: kMainColor,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      // Count badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: rankColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${disease.repetitions}',
                          style: Styles.textStyle15.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Animated bar with percentage label
                  Stack(
                    children: [
                      // Background bar
                      Container(
                        height: 12,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      // Foreground animated bar
                      AnimatedBuilder(
                        animation: animation,
                        builder: (context, child) {
                          return Container(
                            height: 12,
                            width: MediaQuery.of(context).size.width * 
                                percentage * animation.value * 0.7,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  rankColor.withOpacity(0.7),
                                  rankColor,
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(6),
                              boxShadow: [
                                BoxShadow(
                                  color: rankColor.withOpacity(0.3),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  // Percentage text
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        '${(percentage * 100).toStringAsFixed(1)}%',
                        style: Styles.textStyle12.copyWith(
                          color: rankColor.withOpacity(0.9),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Expanded details when selected
            if (isSelected)
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: rankColor.withOpacity(0.05),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                  border: Border.all(
                    color: rankColor.withOpacity(0.1),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (disease.description.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Text(
                          disease.description,
                          style: Styles.textStyle13.copyWith(
                            color: kMainColor.withOpacity(0.8),
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    // Info grid
                    Row(
                      children: [
                        // Left column
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InfoRow(
                                icon: Icons.repeat_rounded,
                                label: 'Occurrences',
                                value: '${disease.repetitions} times',
                                color: rankColor,
                              ),
                              const SizedBox(height: 8),
                              InfoRow(
                                icon: Icons.science_outlined,
                                label: 'Scientific',
                                value: disease.scientificName,
                                color: rankColor,
                              ),
                            ],
                          ),
                        ),
                        // Right column
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InfoRow(
                                icon: Icons.category_outlined,
                                label: 'Type',
                                value: disease.typeDisease,
                                color: rankColor,
                              ),
                              const SizedBox(height: 8),
                              InfoRow(
                                icon: Icons.healing_outlined,
                                label: 'Solutions',
                                value: '${disease.solutions.length} available',
                                color: rankColor,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
