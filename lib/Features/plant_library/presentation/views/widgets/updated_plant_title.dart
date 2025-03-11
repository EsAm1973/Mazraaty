import 'package:flutter/material.dart';
import 'package:mazraaty/Core/utils/styles.dart';

class UpdatedDetailsPlantTitle extends StatelessWidget {
  const UpdatedDetailsPlantTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
              text: 'Mentha-Mint ',
              style: Styles.textStyle30
                  .copyWith(color: Colors.black, fontWeight: FontWeight.bold)),
          TextSpan(
              text: 'a species of ',
              style: Styles.textStyle20.copyWith(color: Colors.black)),
          TextSpan(
              text: 'Mentha',
              style: Styles.textStyle30
                  .copyWith(color: Colors.black, fontWeight: FontWeight.bold)),
        ],
      ),
      maxLines: 2,
      softWrap: true,
    );
  }
}
