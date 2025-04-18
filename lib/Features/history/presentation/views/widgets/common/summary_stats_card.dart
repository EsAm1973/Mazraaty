import 'package:flutter/material.dart';
import 'package:mazraaty/Core/utils/styles.dart';
import 'package:mazraaty/Features/history/data/models/history_model.dart';
import 'package:mazraaty/constants.dart';

class SummaryStatsCard extends StatelessWidget {
  final List<HistoryDisease> diseases;

  const SummaryStatsCard({
    super.key,
    required this.diseases,
  });

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions for responsive sizing
    final screenWidth = MediaQuery.of(context).size.width;

    // Calculate responsive dimensions
    final bottomMargin = screenWidth * 0.05; // 5% of screen width
    final borderRadius = screenWidth * 0.05; // 5% of screen width
    final padding = screenWidth * 0.05; // 5% of screen width

    // Calculate total occurrences
    final totalOccurrences = diseases.fold(0, (sum, disease) => sum + disease.repetitions);

    // Calculate most common disease
    final mostCommonDisease = diseases.first;

    // Calculate average occurrences per disease
    final averageOccurrences = totalOccurrences / diseases.length;

    return Container(
      margin: EdgeInsets.only(bottom: bottomMargin),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: kMainColor.withOpacity(0.2),
            blurRadius: screenWidth * 0.04, // 4% of screen width
            spreadRadius: 0,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background with gradient and pattern
          ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius),
            child: Container(
              padding: EdgeInsets.all(padding),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    kMainColor.withOpacity(0.9),
                    kMainColor,
                  ],
                ),
              ),
              child: Stack(
                children: [
                  // Pattern overlay - responsive circle sizes
                  Positioned(
                    right: -screenWidth * 0.05, // 5% of screen width
                    top: -screenWidth * 0.05, // 5% of screen width
                    child: Opacity(
                      opacity: 0.1,
                      child: Container(
                        width: screenWidth * 0.3, // 30% of screen width
                        height: screenWidth * 0.3, // 30% of screen width
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: -screenWidth * 0.075, // 7.5% of screen width
                    bottom: -screenWidth * 0.075, // 7.5% of screen width
                    child: Opacity(
                      opacity: 0.08,
                      child: Container(
                        width: screenWidth * 0.25, // 25% of screen width
                        height: screenWidth * 0.25, // 25% of screen width
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  // Content
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top row with total occurrences
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Total occurrences - with responsive sizing
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.analytics_rounded,
                                    color: Colors.white,
                                    size: screenWidth * 0.04, // 4% of screen width
                                  ),
                                  SizedBox(width: screenWidth * 0.015), // 1.5% of screen width
                                  Text(
                                    'TOTAL OCCURRENCES',
                                    style: screenWidth < 400
                                      ? Styles.textStyle12.copyWith(
                                          color: Colors.white.withOpacity(0.9),
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 0.5,
                                        )
                                      : Styles.textStyle13.copyWith(
                                          color: Colors.white.withOpacity(0.9),
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 0.5,
                                        ),
                                  ),
                                ],
                              ),
                              SizedBox(height: screenWidth * 0.015), // 1.5% of screen width
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Text(
                                    '$totalOccurrences',
                                    style: TextStyle(
                                      fontSize: screenWidth < 400 ? 26 : (screenWidth < 600 ? 30 : 34),
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: screenWidth * 0.01), // 1% of screen width
                                  Text(
                                    'times',
                                    style: TextStyle(
                                      fontSize: screenWidth < 400 ? 13 : (screenWidth < 600 ? 15 : 17),
                                      color: Colors.white.withOpacity(0.9),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          // Trend icon with animation - responsive sizing
                          TweenAnimationBuilder<double>(
                            tween: Tween<double>(begin: 0.0, end: 1.0),
                            duration: const Duration(milliseconds: 1000),
                            curve: Curves.elasticOut,
                            builder: (context, value, child) {
                              // Calculate responsive sizes
                              final iconSize = screenWidth * 0.06; // 6% of screen width
                              final containerPadding = screenWidth * 0.03; // 3% of screen width
                              final borderWidth = screenWidth * 0.005; // 0.5% of screen width

                              return Transform.scale(
                                scale: value,
                                child: Container(
                                  padding: EdgeInsets.all(containerPadding),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.3),
                                      width: borderWidth,
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.trending_up_rounded,
                                    color: Colors.white,
                                    size: iconSize,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: screenWidth * 0.05), // 5% of screen width
                      // Stats grid - responsive spacing
                      Row(
                        children: [
                          // Most common disease
                          Expanded(
                            child: _buildStatCard(
                              'Most Common',
                              mostCommonDisease.originName,
                              '${mostCommonDisease.repetitions} times',
                              Icons.star_rounded,
                              screenWidth, // Pass screen width to stat card
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.05), // 5% of screen width
                          // Average occurrences
                          Expanded(
                            child: _buildStatCard(
                              'Average',
                              averageOccurrences.toStringAsFixed(1),
                              'per disease',
                              Icons.bar_chart_rounded,
                              screenWidth, // Pass screen width to stat card
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, String subtitle, IconData icon, double screenWidth) {
    // Calculate responsive dimensions
    final padding = screenWidth * 0.035; // 3.5% of screen width
    final borderRadius = screenWidth * 0.03; // 3% of screen width
    final iconSize = screenWidth * 0.035; // 3.5% of screen width
    final iconSpacing = screenWidth * 0.01; // 1% of screen width
    final verticalSpacing = screenWidth * 0.015; // 1.5% of screen width

    // Calculate responsive font sizes - smaller on narrow screens to prevent overflow
    final labelFontSize = screenWidth < 360 ? 9.0 : (screenWidth < 400 ? 10.0 : (screenWidth < 600 ? 12.0 : 13.0));
    final valueFontSize = screenWidth < 360 ? 12.0 : (screenWidth < 400 ? 13.0 : (screenWidth < 600 ? 15.0 : 16.0));
    final subtitleFontSize = screenWidth < 360 ? 9.0 : (screenWidth < 400 ? 10.0 : (screenWidth < 600 ? 12.0 : 13.0));

    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: screenWidth * 0.0025, // 0.25% of screen width
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: Colors.white.withOpacity(0.9),
                size: iconSize,
              ),
              SizedBox(width: iconSpacing),
              Flexible(
                child: Text(
                  label.toUpperCase(),
                  style: TextStyle(
                    fontSize: labelFontSize,
                    color: Colors.white.withOpacity(0.8),
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: verticalSpacing),
          SizedBox(
            width: double.infinity,
            child: Text(
              value,
              style: TextStyle(
                fontSize: valueFontSize,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Text(
              subtitle,
              style: TextStyle(
                fontSize: subtitleFontSize,
                color: Colors.white.withOpacity(0.8),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
