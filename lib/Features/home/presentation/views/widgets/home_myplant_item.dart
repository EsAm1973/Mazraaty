import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mazraaty/Features/home/data/models/plant_garden.dart';
import 'package:mazraaty/constants.dart';

class HomeMyPlantItem extends StatefulWidget {
  const HomeMyPlantItem({super.key, required this.plant});
  final PlantGarden plant;

  @override
  State<HomeMyPlantItem> createState() => _HomeMyPlantItemState();
}

class _HomeMyPlantItemState extends State<HomeMyPlantItem> with TickerProviderStateMixin {
  // Animation controllers
  late AnimationController _pulseController;
  late AnimationController _waterAnimationController;
  late AnimationController _rotationController;

  // Animations
  late Animation<double> _pulseAnimation;
  late Animation<double> _waterHeightAnimation;
  late Animation<double> _rotationAnimation;

  // State variables
  bool _isHovering = false;

  // For 3D effect
  Offset _dragPosition = Offset.zero;
  final double _maxRotationX = 0.05;
  final double _maxRotationY = 0.05;

  @override
  void initState() {
    super.initState();

    // Pulse animation for tap effect
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.03).animate(
      CurvedAnimation(
        parent: _pulseController,
        curve: Curves.easeInOut,
      ),
    );

    // Water animation for the liquid effect
    _waterAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _waterHeightAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _waterAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    // Subtle rotation animation for 3D effect
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);

    _rotationAnimation = Tween<double>(begin: -0.01, end: 0.01).animate(
      CurvedAnimation(
        parent: _rotationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _waterAnimationController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  void _waterPlant() {
    _waterAnimationController.reset();
    _waterAnimationController.forward();

    // Here you would update the plant's water level in a real app
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${widget.plant.name} has been watered!'),
        backgroundColor: Colors.blue,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Calculate water level height based on plant data
    final waterLevel = widget.plant.waterLevel ?? _getProgressValue(widget.plant.status);

    // We'll use AnimatedContainer to handle the height changes automatically

    return GestureDetector(
      onTap: () {
        // Navigate to plant details
      },
      onTapDown: (_) {
        _pulseController.forward();
        setState(() => _isHovering = true);
      },
      onTapUp: (_) {
        _pulseController.reverse();
        setState(() => _isHovering = false);
      },
      onTapCancel: () {
        _pulseController.reverse();
        setState(() => _isHovering = false);
      },
      // For 3D effect on pan
      onPanUpdate: (details) {
        setState(() {
          // Calculate drag position relative to card size
          final RenderBox box = context.findRenderObject() as RenderBox;
          final size = box.size;
          _dragPosition = Offset(
            (details.localPosition.dx / size.width) * 2 - 1,
            (details.localPosition.dy / size.height) * 2 - 1,
          );
        });
      },
      onPanEnd: (_) {
        setState(() {
          // Reset to center when not dragging
          _dragPosition = Offset.zero;
        });
      },
      child: AnimatedBuilder(
        animation: Listenable.merge([_pulseAnimation, _rotationAnimation]),
        builder: (context, child) {
          // Calculate 3D rotation based on drag position
          final rotationY = _dragPosition.dx * _maxRotationY + _rotationAnimation.value;
          final rotationX = -_dragPosition.dy * _maxRotationX;

          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001) // perspective
              ..rotateX(rotationX)
              ..rotateY(rotationY),
            child: Transform.scale(
              scale: _pulseAnimation.value,
              child: child,
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              // Main shadow
              BoxShadow(
                color: _isHovering
                    ? kMainColor.withAlpha(40)
                    : Colors.black.withAlpha(15),
                blurRadius: _isHovering ? 10 : 6,
                spreadRadius: _isHovering ? 2 : 0,
                offset: const Offset(0, 3),
              ),
              // Subtle top highlight for 3D effect
              BoxShadow(
                color: Colors.white.withAlpha(100),
                blurRadius: 4,
                spreadRadius: 0,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Plant image with parallax effect
              Stack(
                children: [
                  // Parallax image effect
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    child: AnimatedBuilder(
                      animation: _rotationAnimation,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(
                            _dragPosition.dx * -5,
                            _dragPosition.dy * -5,
                          ),
                          child: child,
                        );
                      },
                      child: Image.asset(
                        widget.plant.imageUrl,
                        height: 130,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  // Status badge
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getStatusColor(widget.plant.status).withAlpha(220),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(40),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _getStatusIcon(widget.plant.status),
                            size: 10,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            widget.plant.status,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Plant type badge
                  if (widget.plant.plantType != null)
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(120),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          widget.plant.plantType!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                ],
              ),

              // Plant info section
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Plant name only (removed menu)
                    Text(
                      widget.plant.name,
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    // Quick action buttons in a row (always visible)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildActionButton(
                            icon: Icons.water_drop,
                            color: Colors.blue,
                            label: 'Water',
                            onTap: _waterPlant,
                          ),
                          _buildActionButton(
                            icon: Icons.eco,
                            color: Colors.green,
                            label: 'Feed',
                            onTap: () {},
                          ),
                          _buildActionButton(
                            icon: Icons.edit,
                            color: Colors.orange,
                            label: 'Notes',
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Health progress bar
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Health',
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                color: Colors.grey[700],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              '${(_getProgressValue(widget.plant.status) * 100).toInt()}%',
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                color: _getStatusColor(widget.plant.status),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Stack(
                          children: [
                            // Base progress bar
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: LinearProgressIndicator(
                                value: _getProgressValue(widget.plant.status),
                                backgroundColor: Colors.grey[200],
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  _getStatusColor(widget.plant.status),
                                ),
                                minHeight: 8,
                              ),
                            ),

                            // Shimmer effect on progress bar
                            Positioned.fill(
                              child: AnimatedBuilder(
                                animation: _rotationController,
                                builder: (context, child) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: ShaderMask(
                                      shaderCallback: (bounds) {
                                        return LinearGradient(
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                          colors: [
                                            Colors.white.withAlpha(0),
                                            Colors.white.withAlpha(100),
                                            Colors.white.withAlpha(0),
                                          ],
                                          stops: [
                                            0.0,
                                            0.5 + _rotationAnimation.value,
                                            1.0,
                                          ],
                                        ).createShader(bounds);
                                      },
                                      blendMode: BlendMode.srcIn,
                                      child: Container(
                                        height: 8,
                                        color: Colors.white.withAlpha(50),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Water level indicator with animation
                    Row(
                      children: [
                        // Water drop icon with animated water level
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: Stack(
                            children: [
                              // Water drop outline
                              Icon(
                                Icons.water_drop_outlined,
                                size: 24,
                                color: Colors.blue[300],
                              ),

                              // Animated water fill
                              AnimatedBuilder(
                                animation: Listenable.merge([
                                  _waterAnimationController,
                                  _rotationController,
                                ]),
                                builder: (context, child) {
                                  // Calculate the fill level
                                  final fillLevel = _waterAnimationController.isAnimating
                                      ? _waterHeightAnimation.value
                                      : waterLevel;

                                  // Add a wave effect
                                  final waveOffset = math.sin(_rotationController.value * 10) * 0.05;
                                  final adjustedFillLevel = (fillLevel + waveOffset).clamp(0.0, 1.0);

                                  return ClipPath(
                                    clipper: WaterDropClipper(
                                      fillLevel: adjustedFillLevel,
                                    ),
                                    child: Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Colors.blue[300]!,
                                            Colors.blue[600]!,
                                          ],
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.water_drop,
                                        size: 24,
                                        color: Colors.white.withAlpha(200),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 8),

                        // Last watered text
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Watered ${widget.plant.lastWatered} ago',
                                style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              if (widget.plant.nextWateringDate != null)
                                Text(
                                  'Next: ${_getNextWateringText(widget.plant.nextWateringDate!)}',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 11,
                                    color: Colors.grey[600],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withAlpha(30),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 16,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          SizedBox(
            height: 14, // Fixed height for text
            child: Text(
              label,
              style: GoogleFonts.montserrat(
                fontSize: 10,
                color: Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'healthy':
        return Colors.green;
      case 'need water':
        return Colors.orange;
      case 'need attention':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'healthy':
        return Icons.check_circle;
      case 'need water':
        return Icons.water_drop;
      case 'need attention':
        return Icons.warning;
      default:
        return Icons.info;
    }
  }

  double _getProgressValue(String status) {
    switch (status.toLowerCase()) {
      case 'healthy':
        return 1.0;
      case 'need water':
        return 0.5;
      case 'need attention':
        return 0.3;
      default:
        return 0.0;
    }
  }

  String _getNextWateringText(DateTime nextWatering) {
    final now = DateTime.now();
    final difference = nextWatering.difference(now);

    if (difference.isNegative) {
      return 'Overdue';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours';
    } else {
      return '${difference.inDays} days';
    }
  }
}

// Custom clipper for water drop shape
class WaterDropClipper extends CustomClipper<Path> {
  final double fillLevel;

  WaterDropClipper({required this.fillLevel});

  @override
  Path getClip(Size size) {
    final path = Path();
    final height = size.height;
    final width = size.width;

    // Calculate fill height from bottom
    final fillHeight = height * fillLevel;

    // Only show the bottom part of the water drop based on fill level
    if (fillLevel > 0) {
      path.moveTo(0, height - fillHeight);
      path.lineTo(0, height);
      path.lineTo(width, height);
      path.lineTo(width, height - fillHeight);
      path.close();
    }

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
