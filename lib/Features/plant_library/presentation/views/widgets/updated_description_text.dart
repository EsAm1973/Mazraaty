import 'package:flutter/material.dart';
import 'package:mazraaty/Core/utils/styles.dart';

class UpdatedDetailsPlantDescription extends StatefulWidget {
  const UpdatedDetailsPlantDescription({super.key});

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
          style: Styles.textStyle23.copyWith(
              color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        AnimatedCrossFade(
          firstChild: const Text(
            "Mint is an aromatic plant that is almost entirely perennial, They have widely spread underground branching stems.",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Styles.textStyle15,
          ),
          secondChild: const Text(
            "Mint is an aromatic plant that is almost entirely perennial, They have widely spread underground branching stems.\n\nMint is also used in various culinary and medicinal applications due to its refreshing aroma and health benefits.",
            style: Styles.textStyle15,
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
