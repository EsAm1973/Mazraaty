import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;

class HomeAppFeatures extends StatefulWidget {
  const HomeAppFeatures({super.key});

  @override
  State<HomeAppFeatures> createState() => _HomeAppFeaturesState();
}

class _HomeAppFeaturesState extends State<HomeAppFeatures> {
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
    final List<FeatureItem> features = [
      FeatureItem(
        icon: Icons.healing,
        title: 'Plant Disease Detection',
        description: 'Identify plant diseases with AI technology',
        color: Colors.red.shade700,
      ),
      FeatureItem(
        icon: Icons.local_florist,
        title: 'Library of Plants',
        description: 'Explore a vast collection of plant species',
        color: Colors.green.shade700,
      ),
      FeatureItem(
        icon: Icons.chat_bubble_outline,
        title: 'AI Plant Chat',
        description: 'Chat with AI about specific plants',
        color: Colors.blue.shade600,
      ),
      FeatureItem(
        icon: Icons.history,
        title: 'Disease History',
        description: 'Track your plants\' disease history',
        color: Colors.purple.shade600,
      ),
      FeatureItem(
        icon: Icons.bug_report,
        title: 'Common Diseases',
        description: 'Learn about common plant diseases',
        color: Colors.orange.shade700,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header section
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              // Check if we're on a small screen
              final bool isSmallScreen = constraints.maxWidth < 360;

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            color: Colors.green.shade700,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Title
                        Flexible(
                          child: Text(
                            'Key Features',
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
                ],
              );
            },
          ),
        ),
        // Feature cards with PageView
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: LayoutBuilder(
            builder: (context, constraints) {
              // Adjust height based on screen width
              final double cardHeight = constraints.maxWidth < 360 ? 180 : 200;

              return SizedBox(
                height: cardHeight,
                child: PageView.builder(
                  controller: _pageController,
                  physics: const BouncingScrollPhysics(),
                  padEnds: false,
                  itemCount: features.length,
                  itemBuilder: (context, index) {
                    // Add a slight rotation effect to each card
                    return Transform.rotate(
                      angle: math.pi / 180 * (index % 2 == 0 ? 0.5 : -0.5),
                      child: _buildFeatureCard(features[index], index),
                    );
                  },
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        // Page indicators
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              features.length,
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
                        ? features[index].color
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

  Widget _buildFeatureCard(FeatureItem feature, int index) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Check if we're on a small screen
        final bool isSmallScreen = constraints.maxWidth < 360;
        final bool isMediumScreen = constraints.maxWidth < 450 && constraints.maxWidth >= 360;

        return Container(
          margin: const EdgeInsets.only(right: 16, top: 4, bottom: 4),
          padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: feature.color.withAlpha(40),
                blurRadius: 8,
                spreadRadius: 0,
                offset: const Offset(0, 2),
              ),
            ],
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white,
                feature.color.withAlpha(30),
              ],
            ),
            border: Border.all(
              color: feature.color.withAlpha(50),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              // Feature icon
              Container(
                padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
                decoration: BoxDecoration(
                  color: feature.color.withAlpha(30),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: feature.color.withAlpha(30),
                      blurRadius: 8,
                      spreadRadius: 0,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  feature.icon,
                  color: feature.color,
                  size: isSmallScreen ? 24 : 32,
                ),
              ),
              SizedBox(width: isSmallScreen ? 12 : 16),

              // Feature content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Feature title
                    Text(
                      feature.title,
                      style: GoogleFonts.montserrat(
                        fontSize: isSmallScreen ? 16 : (isMediumScreen ? 17 : 18),
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: isSmallScreen ? 6 : 8),

                    // Feature description
                    Text(
                      feature.description,
                      style: GoogleFonts.montserrat(
                        fontSize: isSmallScreen ? 12 : 14,
                        color: Colors.grey[600],
                        height: 1.3,
                      ),
                      maxLines: isSmallScreen ? 2 : 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: isSmallScreen ? 12 : 16),

                    // Learn more button
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: isSmallScreen ? 10 : 12,
                            vertical: isSmallScreen ? 4 : 6,
                          ),
                          decoration: BoxDecoration(
                            color: feature.color.withAlpha(30),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'Learn More',
                            style: GoogleFonts.montserrat(
                              fontSize: isSmallScreen ? 10 : 12,
                              fontWeight: FontWeight.w500,
                              color: feature.color,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class FeatureItem {
  final IconData icon;
  final String title;
  final String description;
  final Color color;

  FeatureItem({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });
}
