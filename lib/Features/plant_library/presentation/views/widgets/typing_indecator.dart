import 'dart:math' as math;

import 'package:flutter/material.dart';

class TypingIndicator extends StatefulWidget {
  final Color bubbleColor;
  final Color flashingCircleDarkColor;
  final Color flashingCircleBrightColor;
  final double dotSize;

  const TypingIndicator({
    super.key,
    this.bubbleColor = const Color(0xFFE0E0E0),
    this.flashingCircleDarkColor = const Color(0xFF81C784),
    this.flashingCircleBrightColor = const Color(0xFF66BB6A),
    this.dotSize = 7.0,
  });

  @override
  State<TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator>
    with TickerProviderStateMixin {
  late AnimationController _appearanceController;
  late Animation<double> _indicatorSpaceAnimation;

  late AnimationController _repeatingController;
  final List<Interval> _dotIntervals = const [
    Interval(0.0, 0.5, curve: Curves.easeOut),
    Interval(0.2, 0.7, curve: Curves.easeOut),
    Interval(0.4, 0.9, curve: Curves.easeOut),
  ];

  @override
  void initState() {
    super.initState();

    _appearanceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 750),
    );

    _indicatorSpaceAnimation = CurvedAnimation(
      parent: _appearanceController,
      curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
    ).drive(Tween<double>(begin: 0.0, end: 40.0));

    _appearanceController.forward();

    _repeatingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _repeatingController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });

    // Start the animation immediately
    _repeatingController.repeat();
  }

  @override
  void dispose() {
    _repeatingController.stop();
    _repeatingController.dispose();
    _appearanceController.stop();
    _appearanceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 20,
      child: AnimatedBuilder(
        animation: _appearanceController,
        builder: (context, child) {
          return Container(
            height: 20,
            width: _indicatorSpaceAnimation.value,
            decoration: BoxDecoration(
              color: widget.bubbleColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildFlashingCircle(0),
                _buildFlashingCircle(1),
                _buildFlashingCircle(2),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildFlashingCircle(int index) {
    return AnimatedBuilder(
      animation: _repeatingController,
      builder: (context, child) {
        final circleFlashPercent = _dotIntervals[index].transform(
          _repeatingController.value,
        );
        final circleColorPercent = math.sin(math.pi * circleFlashPercent);

        return Container(
          width: widget.dotSize,
          height: widget.dotSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color.lerp(
              widget.flashingCircleDarkColor,
              widget.flashingCircleBrightColor,
              circleColorPercent,
            ),
          ),
        );
      },
    );
  }
}
