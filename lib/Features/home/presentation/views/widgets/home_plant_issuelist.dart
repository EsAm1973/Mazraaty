import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mazraaty/Features/home/data/models/common_disease.dart';
import 'package:mazraaty/Features/home/data/models/plant_issue.dart';
import 'package:mazraaty/Features/home/presentation/manager/Common%20Disease%20Cubit/common_disease_cubit.dart';
import 'package:mazraaty/Features/home/presentation/views/widgets/home_issue_listitem.dart';
import 'package:mazraaty/constants.dart';

class HomeRecentPlantIssue extends StatefulWidget {
  const HomeRecentPlantIssue({super.key});

  @override
  State<HomeRecentPlantIssue> createState() => _HomeRecentPlantIssueState();
}

class _HomeRecentPlantIssueState extends State<HomeRecentPlantIssue> {
  final PageController _pageController = PageController(viewportFraction: 0.85);
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      int next = _pageController.page!.round();
      if (_currentPage != next) {
        setState(() {
          _currentPage = next;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommonDiseaseCubit, CommonDiseaseState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header section
            Padding(
              padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  // Check if we're on a small screen
                  final bool isSmallScreen = constraints.maxWidth < 360;

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Left side - Title with icon
                      Expanded(
                        child: Row(
                          children: [
                            // Decorative element
                            Container(
                              height: 24,
                              width: 4,
                              decoration: BoxDecoration(
                                color: Colors.red.shade400,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            const SizedBox(width: 12),
                            // Title
                            Flexible(
                              child: Text(
                                "Common Diseases",
                                style: GoogleFonts.poppins(
                                  fontSize: isSmallScreen ? 18 : 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey.shade800,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Right side - View All button
                      OutlinedButton.icon(
                        onPressed: () {
                          // Navigate to all issues
                        },
                        icon: Icon(
                          Icons.arrow_forward,
                          size: isSmallScreen ? 14 : 16,
                        ),
                        label: Text(
                          isSmallScreen ? 'All' : 'View All',
                          style: TextStyle(
                            fontSize: isSmallScreen ? 12 : 14,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: kMainColor,
                          side: const BorderSide(color: kMainColor, width: 1.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: isSmallScreen ? 8 : 12,
                            vertical: isSmallScreen ? 6 : 8,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            if (state is CommonDiseaseLoading)
              const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: CircularProgressIndicator(color: kMainColor),
                ),
              )
            else if (state is CommonDiseaseError)
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: Column(
                    children: [
                      Icon(Icons.error_outline,
                          color: Colors.red.shade400, size: 40),
                      const SizedBox(height: 16),
                      Text(
                        "Failed to load diseases",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: () => context
                            .read<CommonDiseaseCubit>()
                            .fetchCommonDiseases(),
                        child: const Text("Retry"),
                      ),
                    ],
                  ),
                ),
              )
            else if (state is CommonDiseaseLoaded && state.diseases.isNotEmpty)
              _buildDiseasePageView(state.diseases)
            else
              _buildPlaceholderContent(),
          ],
        );
      },
    );
  }

  Widget _buildDiseasePageView(List<DiseaseModel> diseases) {
    return Column(
      children: [
        // Disease cards with PageView
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: LayoutBuilder(
            builder: (context, constraints) {
              // Adjust height based on screen width
              final double cardHeight = constraints.maxWidth < 360 ? 310 : 340;

              return SizedBox(
                height: cardHeight,
                child: PageView.builder(
                  controller: _pageController,
                  physics: const BouncingScrollPhysics(),
                  // Adjust padding to align first card with left edge
                  padEnds: false,
                  itemCount: diseases.length,
                  itemBuilder: (context, index) {
                    // Convert DiseaseModel to PlantIssue for display
                    final disease = diseases[index];
                    final plantIssue = _convertToPlantIssue(disease);

                    // Add staggered animation effect
                    return TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.0, end: 1.0),
                      duration: Duration(milliseconds: 500 + (index * 100)),
                      curve: Curves.easeOutQuad,
                      builder: (context, value, child) {
                        return Transform.translate(
                          offset: Offset(50 * (1 - value), 0),
                          child: Opacity(
                            opacity: value,
                            child: child,
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                          right: 16,
                          top: 4,
                          bottom: 4,
                        ),
                        child: HomePlantIssueItem(
                          plantIssue: plantIssue,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),

        // Page indicators
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              diseases.length,
              (index) => GestureDetector(
                onTap: () {
                  _pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.only(right: 8),
                  height: 8,
                  width: _currentPage == index ? 24 : 8,
                  decoration: BoxDecoration(
                    color: _currentPage == index
                        ? Colors.red.shade400
                        : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Convert DiseaseModel to PlantIssue for compatibility with existing UI
  PlantIssue _convertToPlantIssue(DiseaseModel disease) {
    return PlantIssue(
      name: disease.originName,
      description: disease.description,
      image: disease.imageUrl, // Use imageUrl from API
      severity: disease.severity,
      severityColor: disease.severityColor ?? Colors.orange,
    );
  }

  // Placeholder content when no data is available
  Widget _buildPlaceholderContent() {
    // Use the existing mock data as fallback
    final List<PlantIssue> mockIssues = [
      PlantIssue(
        name: 'Leaf Spot Disease',
        description: 'Common fungal infection',
        image: 'assets/images/similar1.png',
        severity: 'Common',
        severityColor: Colors.orange,
      ),
      PlantIssue(
        name: 'Powdery Mildew',
        description: 'White powdery spots',
        image: 'assets/images/similar2.png',
        severity: 'Severe',
        severityColor: Colors.red,
      ),
      PlantIssue(
        name: 'Root Rot',
        description: 'Caused by overwatering',
        image: 'assets/images/similar3.png',
        severity: 'Critical',
        severityColor: Colors.red.shade900,
      ),
      // Add more mock data as needed
    ];

    return _buildDiseasePageView(mockIssues
        .map((issue) => DiseaseModel(
              originName: issue.name,
              description: issue.description,
              image: issue.image,
              imageUrl: issue.image,
              severity: issue.severity,
              severityColor: issue.severityColor,
            ))
        .toList());
  }
}
