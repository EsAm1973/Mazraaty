import 'package:flutter/material.dart';
import 'package:mazraaty/Core/utils/styles.dart';
import 'package:mazraaty/Features/history/data/models/history_model.dart';
import 'package:mazraaty/Features/history/presentation/views/widgets/charts/bar_chart_item.dart';
import 'package:mazraaty/Features/history/presentation/views/widgets/common/empty_state.dart';
import 'package:mazraaty/Features/history/presentation/views/widgets/common/summary_stats_card.dart';
import 'package:mazraaty/constants.dart';

class HistoryChart extends StatefulWidget {
  final List<HistoryDisease> diseases;

  const HistoryChart({super.key, required this.diseases});

  @override
  State<HistoryChart> createState() => _HistoryChartState();
}

class _HistoryChartState extends State<HistoryChart> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  // Track if a bar is selected
  int touchedIndex = -1;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOutCubic,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Sort diseases by repetition count (descending)
    final sortedDiseases = List<HistoryDisease>.from(widget.diseases)
      ..sort((a, b) => b.repetitions.compareTo(a.repetitions));

    // Take top 5 diseases for better visualization
    final topDiseases = sortedDiseases.take(5).toList();

    // Find the maximum repetition count for scaling
    final maxRepetitions = topDiseases.isNotEmpty
        ? topDiseases.map((d) => d.repetitions).reduce((a, b) => a > b ? a : b)
        : 1;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: topDiseases.isEmpty
            ? _buildEmptyState()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Legend at the top
                  Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: kMainColor.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: kMainColor.withOpacity(0.1),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.info_outline, color: kMainColor, size: 18),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            'Tap on a bar to see more details',
                            style: Styles.textStyle13.copyWith(
                              color: kMainColor.withOpacity(0.8),
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Chart area with scrollable content including summary stats
                  Expanded(
                    child: _buildScrollableBarChart(topDiseases, maxRepetitions),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildScrollableBarChart(List<HistoryDisease> diseases, int maxRepetitions) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.zero,
      children: [
        // Summary statistics at the top of the scrollable area
        _buildSummaryStats(diseases),
        // Bar chart items
        ...diseases.asMap().entries.map((entry) {
          final index = entry.key;
          final disease = entry.value;
          final percentage = disease.repetitions / maxRepetitions;
          final rank = index + 1;
          final rankColor = _getRankColor(rank);

          return _buildBarItem(disease, percentage, index, rank, rankColor);
        }),
        // Bottom padding
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildSummaryStats(List<HistoryDisease> diseases) {
    return SummaryStatsCard(diseases: diseases);
  }

  Widget _buildEmptyState() {
    return const EmptyStateWidget(
      message: 'No disease data available',
      icon: Icons.bar_chart,
    );
  }

  Widget _buildBarItem(HistoryDisease disease, double percentage, int index, int rank, Color rankColor) {
    return BarChartItem(
      disease: disease,
      percentage: percentage,
      index: index,
      rank: rank,
      rankColor: rankColor,
      touchedIndex: touchedIndex,
      animation: _animation,
      onTap: (idx) {
        setState(() {
          touchedIndex = touchedIndex == idx ? -1 : idx;
        });
      },
    );
  }



  Color _getRankColor(int rank) {
    switch (rank) {
      case 1:
        return const Color(0xFF5C6BC0); // Indigo
      case 2:
        return const Color(0xFF26A69A); // Teal
      case 3:
        return const Color(0xFFFFB74D); // Orange
      case 4:
        return const Color(0xFF7E57C2); // Deep Purple
      case 5:
        return const Color(0xFF66BB6A); // Green
      default:
        return kMainColor;
    }
  }
}
