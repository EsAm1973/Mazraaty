import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mazraaty/constants.dart';

class SymptomItem extends StatefulWidget {
  final String title;
  final String description;
  final int index;
  final bool isLast;

  const SymptomItem({
    super.key,
    required this.title,
    required this.description,
    required this.index,
    this.isLast = false,
  });

  @override
  State<SymptomItem> createState() => _SymptomItemState();
}

class _SymptomItemState extends State<SymptomItem>
    with SingleTickerProviderStateMixin {
  bool isExpanded = false;
  late AnimationController _animationController;
  late Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleExpanded() {
    setState(() {
      isExpanded = !isExpanded;
      if (isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: widget.isLast ? 20.0 : 16.0,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _toggleExpanded,
          borderRadius: BorderRadius.circular(20.0),
          child: Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(
                color: kMainColor.withOpacity(0.1),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: kMainColor.withOpacity(0.08),
                  blurRadius: 20.0,
                  offset: const Offset(0, 8),
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    // Timeline Indicator
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            kMainColor,
                            kMainColor.withOpacity(0.7),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(
                            color: kMainColor.withOpacity(0.3),
                            blurRadius: 12.0,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          "${widget.index + 1}",
                          style: GoogleFonts.cairo(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    
                    const SizedBox(width: 16.0),
                    
                    // Content
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  widget.title,
                                  style: GoogleFonts.cairo(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade800,
                                  ),
                                ),
                              ),
                              AnimatedRotation(
                                turns: isExpanded ? 0.5 : 0,
                                duration: const Duration(milliseconds: 300),
                                child: const Icon(
                                  Icons.keyboard_arrow_down,
                                  color: kMainColor,
                                  size: 24,
                                ),
                              ),
                            ],
                          ),
                          
                          if (!isExpanded) ...[
                            const SizedBox(height: 4.0),
                            Text(
                              widget.description.length > 60
                                  ? "${widget.description.substring(0, 60)}..."
                                  : widget.description,
                              style: GoogleFonts.cairo(
                                fontSize: 14,
                                color: Colors.grey.shade600,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
                
                // Expanded Description
                SizeTransition(
                  sizeFactor: _expandAnimation,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: kMainColor.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(
                          color: kMainColor.withOpacity(0.1),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.info_outline,
                                color: kMainColor,
                                size: 18,
                              ),
                              const SizedBox(width: 8.0),
                              Text(
                                "Description of the symptom",
                                style: GoogleFonts.cairo(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: kMainColor,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12.0),
                          Text(
                            widget.description,
                            style: GoogleFonts.cairo(
                              fontSize: 15,
                              color: Colors.grey.shade700,
                              height: 1.6,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
