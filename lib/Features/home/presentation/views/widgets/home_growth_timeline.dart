import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mazraaty/constants.dart';

class HomeGrowthTimeline extends StatefulWidget {
  const HomeGrowthTimeline({super.key});

  @override
  State<HomeGrowthTimeline> createState() => _HomeGrowthTimelineState();
}

class _HomeGrowthTimelineState extends State<HomeGrowthTimeline> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _progressAnimation;
  
  final List<GrowthStage> _growthStages = [
    GrowthStage(
      title: 'Seed',
      description: 'Your plant journey begins',
      date: '2 months ago',
      icon: Icons.grain,
      isCompleted: true,
    ),
    GrowthStage(
      title: 'Sprout',
      description: 'First leaves appeared',
      date: '6 weeks ago',
      icon: Icons.eco,
      isCompleted: true,
    ),
    GrowthStage(
      title: 'Young Plant',
      description: 'Growing steadily',
      date: '3 weeks ago',
      icon: Icons.spa,
      isCompleted: true,
    ),
    GrowthStage(
      title: 'Mature Plant',
      description: 'Healthy and thriving',
      date: 'Current stage',
      icon: Icons.park,
      isCompleted: false,
    ),
    GrowthStage(
      title: 'Flowering',
      description: 'Blooming expected soon',
      date: 'Coming soon',
      icon: Icons.local_florist,
      isCompleted: false,
    ),
  ];
  
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    
    _progressAnimation = Tween<double>(begin: 0.0, end: 0.75).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Growth Timeline',
          style: GoogleFonts.montserrat(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(10),
                blurRadius: 10,
                spreadRadius: 0,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              // Progress indicator
              AnimatedBuilder(
                animation: _progressAnimation,
                builder: (context, child) {
                  return LinearProgressIndicator(
                    value: _progressAnimation.value,
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation<Color>(kMainColor),
                    minHeight: 6,
                    borderRadius: BorderRadius.circular(3),
                  );
                },
              ),
              const SizedBox(height: 24),
              
              // Timeline items
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _growthStages.length,
                itemBuilder: (context, index) {
                  final stage = _growthStages[index];
                  final isLast = index == _growthStages.length - 1;
                  
                  return _buildTimelineItem(
                    stage: stage,
                    isLast: isLast,
                    index: index,
                  );
                },
              ),
              
              const SizedBox(height: 16),
              
              // View detailed timeline button
              TextButton.icon(
                onPressed: () {
                  // Navigate to detailed timeline
                },
                icon: Icon(
                  Icons.timeline,
                  size: 18,
                  color: kMainColor,
                ),
                label: Text(
                  'View Detailed Timeline',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: kMainColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget _buildTimelineItem({
    required GrowthStage stage,
    required bool isLast,
    required int index,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline connector
          Column(
            children: [
              // Circle indicator
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: stage.isCompleted ? kMainColor : Colors.grey[300],
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 3,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: stage.isCompleted 
                          ? kMainColor.withAlpha(100) 
                          : Colors.grey.withAlpha(50),
                      blurRadius: 8,
                      spreadRadius: 0,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  stage.icon,
                  size: 16,
                  color: stage.isCompleted ? Colors.white : Colors.grey[500],
                ),
              ),
              
              // Vertical line
              if (!isLast)
                AnimatedBuilder(
                  animation: _progressAnimation,
                  builder: (context, child) {
                    // Calculate if this line should be colored based on animation progress
                    final stageProgress = (index + 1) / _growthStages.length;
                    final isColored = _progressAnimation.value >= stageProgress;
                    
                    return Container(
                      width: 2,
                      height: 40,
                      color: isColored ? kMainColor : Colors.grey[300],
                    );
                  },
                ),
            ],
          ),
          
          const SizedBox(width: 16),
          
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      stage.title,
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: stage.isCompleted ? Colors.black87 : Colors.grey[600],
                      ),
                    ),
                    Text(
                      stage.date,
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        color: stage.isCompleted ? kMainColor : Colors.grey[500],
                        fontWeight: stage.isCompleted ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  stage.description,
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                
                // Add milestone photos for completed stages
                if (stage.isCompleted) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _buildMilestonePhoto(),
                      const SizedBox(width: 8),
                      _buildMilestonePhoto(),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildMilestonePhoto() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: const DecorationImage(
          image: AssetImage('assets/images/similar1.png'),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(20),
            blurRadius: 4,
            spreadRadius: 0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
    );
  }
}

class GrowthStage {
  final String title;
  final String description;
  final String date;
  final IconData icon;
  final bool isCompleted;
  
  GrowthStage({
    required this.title,
    required this.description,
    required this.date,
    required this.icon,
    required this.isCompleted,
  });
}
