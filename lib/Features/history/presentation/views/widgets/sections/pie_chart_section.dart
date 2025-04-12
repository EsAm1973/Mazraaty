import 'package:flutter/material.dart';
import 'package:mazraaty/Core/utils/styles.dart';
import 'package:mazraaty/Features/history/data/models/history_model.dart';
import 'package:mazraaty/Features/history/presentation/views/widgets/history_pie_chart.dart';
import 'package:mazraaty/constants.dart';

class PieChartSection extends StatelessWidget {
  final List<dynamic> diseases;

  const PieChartSection({
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
                Icons.pie_chart_rounded,
                color: kMainColor,
                size: 24,
              ),
              const SizedBox(width: 10),
              Text(
                'Disease Distribution',
                style: Styles.textStyle20.copyWith(
                  color: kMainColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              // Info button
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: kMainColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.info_outline,
                  color: kMainColor,
                  size: 18,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Subtitle
          Text(
            'Percentage breakdown of diseases in your farm',
            style: Styles.textStyle13.copyWith(
              color: Colors.grey.shade600,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 16),
          // Pie chart with enhanced styling
          Expanded(
            child: HistoryPieChart(
              diseases: diseases.cast<HistoryDisease>(),
            ),
          ),
        ],
      ),
    );
  }
}
