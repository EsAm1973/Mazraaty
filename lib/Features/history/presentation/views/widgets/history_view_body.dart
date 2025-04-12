import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mazraaty/Core/utils/styles.dart';
import 'package:mazraaty/Features/history/presentation/manager/History/history_cubit.dart';
import 'package:mazraaty/Features/history/presentation/views/widgets/navigation/navigation_tab_bar.dart';
import 'package:mazraaty/Features/history/presentation/views/widgets/sections/bar_chart_section.dart';
import 'package:mazraaty/Features/history/presentation/views/widgets/sections/list_view_section.dart';
import 'package:mazraaty/Features/history/presentation/views/widgets/sections/pie_chart_section.dart';
import 'package:mazraaty/constants.dart';

class HistoryViewBody extends StatefulWidget {
  const HistoryViewBody({super.key});

  @override
  State<HistoryViewBody> createState() => _HistoryViewBodyState();
}

class _HistoryViewBodyState extends State<HistoryViewBody> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    context.read<HistoryCubit>().loadHistory();
    _pageController = PageController(initialPage: 0, viewportFraction: 1.0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HistoryCubit, HistoryState>(
      listener: (context, state) {
        if (state is HistorySaveSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        } else if (state is HistorySaveError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage)),
          );
        } else if (state is HistoryError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        if (state is HistoryLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: kMainColor,
            ),
          );
        } else if (state is HistoryError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  color: Colors.red.shade300,
                  size: 60,
                ),
                const SizedBox(height: 16),
                Text(
                  'Error loading history: ${state.message}',
                  textAlign: TextAlign.center,
                  style: Styles.textStyle16,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    context.read<HistoryCubit>().loadHistory();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kMainColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                  child: const Text('Try Again'),
                ),
              ],
            ),
          );
        } else if (state is HistoryLoaded) {
          final diseases = state.diseases;

          if (diseases.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.history,
                    color: kMainColor.withOpacity(0.5),
                    size: 80,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No History Diseases Found',
                    style: Styles.textStyle20
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.only(top: 20, left: 8, right: 8),
            child: Column(
              children: [
                // Header section with title and subtitle
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title row with icon
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: kMainColor.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.history_rounded,
                              color: kMainColor,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Disease History',
                            style: Styles.textStyle30.copyWith(
                              fontFamily: kfontFamily,
                              color: kMainColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Subtitle with gradient text
                      ShaderMask(
                        shaderCallback: (bounds) {
                          return LinearGradient(
                            colors: [
                              kMainColor,
                              kMainColor.withOpacity(0.7),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(bounds);
                        },
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Track your plant health over time',
                            style: Styles.textStyle15.copyWith(
                              color: Colors
                                  .white, // This will be overridden by the shader
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      // Navigation tabs
                      NavigationTabBar(
                        currentPage: _currentPage,
                        onTabSelected: (index) {
                          _pageController.jumpToPage(index);
                          setState(() {
                            _currentPage = index;
                          });
                        },
                      ),
                    ],
                  ),
                ),

                // Page view with different visualization options
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    physics:
                        const NeverScrollableScrollPhysics(), // Disable swiping
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    children: [
                      // List View
                      ListViewSection(diseases: diseases),
                      // Bar Chart View
                      BarChartSection(diseases: diseases),
                      // Pie Chart View
                      PieChartSection(diseases: diseases),
                    ],
                  ),
                ),
              ],
            ),
          );
        }

        // Default loading state
        return const Center(
          child: CircularProgressIndicator(
            color: kMainColor,
          ),
        );
      },
    );
  }
}
