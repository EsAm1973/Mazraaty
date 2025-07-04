import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SuggestionCard extends StatefulWidget {
  final String title;
  final String emoji;
  final Color color;
  final VoidCallback onTap;

  const SuggestionCard({
    super.key,
    required this.title,
    required this.emoji,
    required this.color,
    required this.onTap,
  });

  @override
  State<SuggestionCard> createState() => _SuggestionCardState();
}

class _SuggestionCardState extends State<SuggestionCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 0.95),
        weight: 1.0,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.95, end: 1.0),
        weight: 1.0,
      ),
    ]).animate(_animationController);

    // Bounce animation on first appearance
    _animateOnce();
  }

  void _animateOnce() async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (!mounted) return;
    _animationController.forward();
    await Future.delayed(const Duration(milliseconds: 300));
    if (!mounted) return;
    _animationController.reverse();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isPressed = true;
        });
        _animationController.forward().then((_) {
          if (!mounted) return;
          _animationController.reverse().then((_) {
            if (mounted) {
              setState(() {
                _isPressed = false;
              });
              widget.onTap();
            }
          });
        });
      },
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: child,
          );
        },
        child: Container(
          width: 140,
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            color: _isPressed ? widget.color.withOpacity(0.8) : Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: widget.color.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
            border: Border.all(
              color: widget.color.withOpacity(0.2),
              width: 1.5,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: widget.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  widget.emoji,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.title,
                style: GoogleFonts.questrial(
                  color: _isPressed ? Colors.white : Colors.black87,
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
