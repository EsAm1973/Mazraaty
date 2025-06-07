import 'package:flutter/material.dart';
import 'package:mazraaty/Core/utils/styles.dart';

class CustomListTileForDeleteAndLogOut extends StatefulWidget {
  const CustomListTileForDeleteAndLogOut({
    super.key,
    required this.leadingIcon,
    required this.title,
    required this.trailingIcon,
    this.onTap,
    this.subtitle,
  });
  final IconData leadingIcon;
  final String title;
  final Widget trailingIcon;
  final VoidCallback? onTap;
  final String? subtitle;

  @override
  State<CustomListTileForDeleteAndLogOut> createState() => _CustomListTileForDeleteAndLogOutState();
}

class _CustomListTileForDeleteAndLogOutState extends State<CustomListTileForDeleteAndLogOut>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _isPressed = true;
    });
    _animationController.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _isPressed = false;
    });
    _animationController.reverse();
  }

  void _handleTapCancel() {
    setState(() {
      _isPressed = false;
    });
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: GestureDetector(
            onTapDown: _handleTapDown,
            onTapUp: _handleTapUp,
            onTapCancel: _handleTapCancel,
            onTap: widget.onTap,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: _isPressed
                    ? Colors.red.withOpacity(0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.transparent,
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  // Enhanced Leading Icon
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      widget.leadingIcon,
                      color: Colors.red,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 16),

                  // Title and Subtitle
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: Styles.textStyle16.copyWith(
                            fontWeight: FontWeight.w500,
                            color: Colors.red,
                          ),
                        ),
                        if (widget.subtitle != null) ...[
                          const SizedBox(height: 2),
                          Text(
                            widget.subtitle!,
                            style: Styles.textStyle13.copyWith(
                              color: Colors.red.withOpacity(0.7),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),

                  // Enhanced Trailing Icon
                  Container(
                    padding: const EdgeInsets.all(4),
                    child: widget.trailingIcon,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
