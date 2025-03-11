import 'package:flutter/material.dart';
import 'package:mazraaty/Features/plant_library/presentation/views/widgets/updated_details_viewbody.dart';
import 'package:mazraaty/Features/plant_library/presentation/views/widgets/updated_tag_item.dart';
import 'package:mazraaty/constants.dart';

class UpdatedDetailsTagsList extends StatelessWidget {
  const UpdatedDetailsTagsList({super.key});
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: tags.map((tag) => UpdatedDetailsTagItem(tag: tag)).toList(),
    );
  }
}
