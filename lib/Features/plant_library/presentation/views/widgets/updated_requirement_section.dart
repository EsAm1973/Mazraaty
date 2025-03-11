import 'package:flutter/material.dart';
import 'package:mazraaty/Core/utils/styles.dart';
import 'package:mazraaty/constants.dart';

class UpdatedDetailsRequirementsSection extends StatelessWidget {
  final List<RequirementItem> requirements;

  const UpdatedDetailsRequirementsSection({super.key, required this.requirements});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Requirements",
          style: Styles.textStyle23.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: requirements
              .map((item) => _buildRequirementCard(context, item))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildRequirementCard(BuildContext context, RequirementItem item) {
    return Container(
      width: (MediaQuery.of(context).size.width - 48) / 2,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ConstrainedBox(
        constraints:
            const BoxConstraints(minHeight: 80), // تعديل الارتفاع الأدنى
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              item.iconPath,
              width: 24,
              height: 24,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    item.title,
                    style: Styles.textStyle15,
                  ),
                  Text(
                    item.description,
                    style: Styles.textStyle15
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
