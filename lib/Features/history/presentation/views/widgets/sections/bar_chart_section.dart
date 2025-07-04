import 'package:flutter/material.dart';
import 'package:mazraaty/Core/utils/styles.dart';
import 'package:mazraaty/Features/history/data/models/history_model.dart';
import 'package:mazraaty/Features/history/presentation/views/widgets/history_chart.dart';
import 'package:mazraaty/constants.dart';

class BarChartSection extends StatelessWidget {
  final List<dynamic> diseases;

  const BarChartSection({
    super.key,
    required this.diseases,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header with info
          Row(
            children: [
              const Icon(
                Icons.bar_chart_rounded,
                color: kMainColor,
                size: 24,
              ),
              const SizedBox(width: 10),
              Text(
                'Disease Frequency',
                style: Styles.textStyle20.copyWith(
                  color: kMainColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              // Info button
            ],
          ),
          const SizedBox(height: 8),
          // Subtitle
          Text(
            'Visualize the most common diseases in your farm',
            style: Styles.textStyle13.copyWith(
              color: Colors.grey.shade600,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 16),
          // Bar chart with enhanced styling
          Expanded(
            child: HistoryChart(
              diseases: diseases.cast<HistoryDisease>(),
            ),
          ),
        ],
      ),
    );
  }
}
