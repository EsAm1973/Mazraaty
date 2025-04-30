import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mazraaty/constants.dart';

class HomePointWidegt extends StatefulWidget {
  const HomePointWidegt({
    super.key,
    required this.points,
    required this.onHowToEarnTap
  });

  final int points;
  final VoidCallback? onHowToEarnTap; // Renamed from onHowToEarnTap to reflect buying more scans

  @override
  State<HomePointWidegt> createState() => _HomePointWidegtState();
}

class _HomePointWidegtState extends State<HomePointWidegt> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _rotateAnimation = Tween<double>(begin: 0, end: 0.05).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Calculate available scans (1 scan = 10 points)
    final int availableScans = widget.points ~/ 10;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.teal.shade50,
            Colors.white,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(15),
            blurRadius: 10,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: Colors.teal.withAlpha(50),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Animated camera/scan icon
              AnimatedBuilder(
                animation: _rotateAnimation,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _rotateAnimation.value,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: kMainColor.withAlpha(30),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        color: kMainColor,
                        size: 24,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(width: 12),

              // Points and scans information
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '$availableScans',
                          style: GoogleFonts.poppins(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: kMainColor,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Scans Available',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '${widget.points} Points (10 points per scan)',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),

              // Info icon with tooltip
              Tooltip(
                message: 'Subscribe to Premium for unlimited scans',
                child: IconButton(
                  icon: const Icon(
                    Icons.info_outline,
                    color: kMainColor,
                    size: 22,
                  ),
                  onPressed: widget.onHowToEarnTap,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Info section
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.blue.shade100,
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: Colors.blue.shade700,
                  size: 20,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Use your scans to identify plant diseases by taking photos of affected plants. Subscribe to Premium for unlimited scans.',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.blue.shade800,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
