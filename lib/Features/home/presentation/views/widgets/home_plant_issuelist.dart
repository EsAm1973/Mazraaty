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
  final ScrollController _scrollController = ScrollController();
  final List<PlantIssue> _issues = [
    PlantIssue(
      name: 'Leaf Spot Disease',
      description: 'Common fungal infection',
      image: 'assets/images/similar1.png',
    ),
    PlantIssue(
      name: 'Powdery Mildew',
      description: 'White powdery spots',
      image: 'assets/images/similar2.png',
    ),
    PlantIssue(
      name: 'Root Rot',
      description: 'Caused by overwatering',
      image: 'assets/images/similar3.png',
    ),
    PlantIssue(
      name: 'Aphid Infestation',
      description: 'Small insects on leaves',
      image: 'assets/images/similar1.png',
    ),
    PlantIssue(
      name: 'Nutrient Deficiency',
      description: 'Yellowing leaves',
      image: 'assets/images/similar2.png',
    ),
  ];

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Recent Plant Issues",
              style: GoogleFonts.montserrat(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextButton.icon(
              onPressed: () {
                // Navigate to all issues
              },
              icon: const Icon(
                Icons.history,
                size: 18,
                color: kMainColor,
              ),
              label: const Text(
                'View All',
                style: TextStyle(
                  color: kMainColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          height: 230,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(5),
                blurRadius: 10,
                spreadRadius: 0,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ListView.builder(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
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
                  padding: const EdgeInsets.only(right: 12),
                  child: HomePlantIssueItem(
                    plantIssue: _issues[index],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
