import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mazraaty/Features/home/data/models/plant_issue.dart';
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
  final List<PlantIssue> _issues = [
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
    PlantIssue(
      name: 'Aphid Infestation',
      description: 'Small insects on leaves',
      image: 'assets/images/similar1.png',
      severity: 'Moderate',
      severityColor: Colors.amber.shade700,
    ),
    PlantIssue(
      name: 'Nutrient Deficiency',
      description: 'Yellowing leaves',
      image: 'assets/images/similar2.png',
      severity: 'Mild',
      severityColor: Colors.green.shade700,
    ),
  ];

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header section
        Padding(
          padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Left side - Title with icon
              Row(
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
                  Text(
                    "Common Diseases",
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  const SizedBox(width: 12),
                ],
              ),

              // Right side - View All button
              OutlinedButton.icon(
                onPressed: () {
                  // Navigate to all issues
                },
                icon: const Icon(
                  Icons.arrow_forward,
                  size: 16,
                ),
                label: const Text('View All'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: kMainColor,
                  side: const BorderSide(color: kMainColor, width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
              ),
            ],
          ),
        ),

        // Disease cards with PageView
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: SizedBox(
            height: 270,
            child: PageView.builder(
              controller: _pageController,
              physics: const BouncingScrollPhysics(),
              // Adjust padding to align first card with left edge
              padEnds: false,
              itemCount: _issues.length,
              itemBuilder: (context, index) {
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
                      plantIssue: _issues[index],
                    ),
                  ),
                );
              },
            ),
          ),
        ),

        // Page indicators
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _issues.length,
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
                        ? (_issues[index].severityColor ?? kMainColor)
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
}
