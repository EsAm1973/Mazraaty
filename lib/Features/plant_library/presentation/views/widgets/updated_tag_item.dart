import 'package:flutter/material.dart';
import 'package:mazraaty/Core/utils/styles.dart';

class UpdatedDetailsTagItem extends StatelessWidget {
  const UpdatedDetailsTagItem({super.key, required this.tag});
  final String tag;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        tag,
        style: Styles.textStyle16
            .copyWith(color: Colors.black, fontWeight: FontWeight.w600),
      ),
    );
  }
}
