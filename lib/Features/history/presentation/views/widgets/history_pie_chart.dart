import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:mazraaty/Core/utils/styles.dart';
import 'package:mazraaty/Features/history/data/models/history_model.dart';
import 'package:mazraaty/Features/history/presentation/views/widgets/charts/pie_chart_painter.dart';
import 'package:mazraaty/Features/history/presentation/views/widgets/common/empty_state.dart';
import 'package:mazraaty/constants.dart';

class HistoryPieChart extends StatefulWidget {
  final List<HistoryDisease> diseases;

  const HistoryPieChart({super.key, required this.diseases});

  @override
  State<HistoryPieChart> createState() => _HistoryPieChartState();
}

class _HistoryPieChartState extends State<HistoryPieChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  int touchedIndex = -1;

  // Define a list of colors for the pie chart sections
  final List<Color> _sectionColors = [
    kMainColor,
    kMainColor.withOpacity(0.8),
    kMainColor.withOpacity(0.6),
    kMainColor.withOpacity(0.4),
    kMainColor.withOpacity(0.3),
    Colors.green.shade300,
    Colors.green.shade200,
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOutCubicEmphasized,
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

    // Take top 6 diseases for better visualization
    final topDiseases = sortedDiseases.take(6).toList();

    // Calculate total repetitions for percentage
    final totalRepetitions = topDiseases.fold(
        0, (sum, disease) => sum + disease.repetitions);

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
      child: topDiseases.isEmpty
          ? const EmptyStateWidget(
              message: 'No disease data available',
              icon: Icons.pie_chart,
            )
          : _buildPieChartContent(topDiseases, totalRepetitions),
    );
  }



  Widget _buildPieChartContent(List<HistoryDisease> diseases, int totalRepetitions) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Pie chart with center info
          Expanded(
            flex: 3,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Animated pie chart with glow effect
                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: kMainColor.withOpacity(0.1),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: CustomPaint(
                        size: const Size(240, 240),
                        painter: PieChartPainter(
                          diseases: diseases,
                          totalRepetitions: totalRepetitions,
                          animation: _animation.value,
                          colors: _sectionColors,
                          touchedIndex: touchedIndex,
                        ),
                      ),
                    );
                  },
                ),
                // Detect touch on pie chart
                GestureDetector(
                  onTapDown: (details) {
                    final RenderBox box = context.findRenderObject() as RenderBox;
                    final Offset center = box.size.center(Offset.zero);
                    final Offset localPosition = details.localPosition;
                    final double dx = localPosition.dx - center.dx;
                    final double dy = localPosition.dy - center.dy;

                    // Calculate angle from center
                    final double angle = (math.atan2(dy, dx) * 180 / math.pi + 360) % 360;

                    // Find which section was touched
                    double startAngle = 0;
                    for (int i = 0; i < diseases.length; i++) {
                      final disease = diseases[i];
                      final percentage = disease.repetitions / totalRepetitions;
                      final sweepAngle = percentage * 360;

                      if (angle >= startAngle && angle <= startAngle + sweepAngle) {
                        setState(() {
                          touchedIndex = touchedIndex == i ? -1 : i;
                        });
                        break;
                      }
                      startAngle += sweepAngle;
                    }
                  },
                  child: Container(
                    width: 240,
                    height: 240,
                    color: Colors.transparent,
                  ),
                ),
                // Center info card
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: touchedIndex != -1
                      ? Container(
                          key: ValueKey(touchedIndex),
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: kMainColor.withOpacity(0.1),
                                blurRadius: 10,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${(diseases[touchedIndex].repetitions / totalRepetitions * 100).toStringAsFixed(1)}%',
                                style: Styles.textStyle23.copyWith(
                                  color: _sectionColors[touchedIndex % _sectionColors.length],
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                diseases[touchedIndex].originName,
                                style: Styles.textStyle12.copyWith(
                                  color: kMainColor,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        )
                      : Container(
                          key: const ValueKey('empty'),
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: kMainColor.withOpacity(0.1),
                                blurRadius: 10,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.touch_app,
                                color: kMainColor.withOpacity(0.7),
                                size: 28,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Tap a section',
                                style: Styles.textStyle12.copyWith(
                                  color: kMainColor.withOpacity(0.7),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                ),
              ],
            ),
          ),
          // Legend cards
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2.5,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: diseases.length,
                itemBuilder: (context, index) {
                  final disease = diseases[index];
                  final percentage = disease.repetitions / totalRepetitions;
                  final color = _sectionColors[index % _sectionColors.length];

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        touchedIndex = touchedIndex == index ? -1 : index;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      decoration: BoxDecoration(
                        color: touchedIndex == index
                            ? color.withOpacity(0.15)
                            : Colors.grey.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: touchedIndex == index
                              ? color
                              : Colors.transparent,
                          width: 1.5,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      child: Row(
                        children: [
                          Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                              boxShadow: touchedIndex == index
                                  ? [
                                      BoxShadow(
                                        color: color.withOpacity(0.4),
                                        blurRadius: 4,
                                        spreadRadius: 1,
                                      ),
                                    ]
                                  : [],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  disease.originName,
                                  style: Styles.textStyle12.copyWith(
                                    color: kMainColor,
                                    fontWeight: touchedIndex == index
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  '${(percentage * 100).toStringAsFixed(1)}%',
                                  style: Styles.textStyle13.copyWith(
                                    color: color,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}


