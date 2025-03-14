import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mazraaty/Core/utils/styles.dart';

class UpdatedDetailsPlantDescription extends StatefulWidget {
  const UpdatedDetailsPlantDescription({super.key, required this.description});
  final String description;
  @override
  State<UpdatedDetailsPlantDescription> createState() =>
      _UpdatedDetailsPlantDescriptionState();
}

class _UpdatedDetailsPlantDescriptionState
    extends State<UpdatedDetailsPlantDescription> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Description",
          style: Styles.textStyle23
              .copyWith(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        AnimatedCrossFade(
          firstChild: Text(
            widget.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Styles.textStyle15,
          ),
          secondChild: Text(
            widget.description,
            style: GoogleFonts.montserrat(fontSize: 16),
          ),
          crossFadeState:
              isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 300),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                isExpanded ? "Read less" : "Read more",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(width: 4),
              Icon(
                isExpanded
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                color: Colors.green,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
