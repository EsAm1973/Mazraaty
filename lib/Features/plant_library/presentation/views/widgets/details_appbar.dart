import 'package:flutter/material.dart';
import 'package:mazraaty/Core/utils/styles.dart';
import 'package:mazraaty/constants.dart';

class DetailsCustomAppBar extends StatelessWidget {
  const DetailsCustomAppBar(
      {super.key, required this.onPressed, required this.name});
  final VoidCallback onPressed;
  final String name;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25, right: 27, left: 27),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: onPressed,
            child: const Icon(
              Icons.arrow_back_ios,
              color: kMainColor,
              size: 30,
            ),
          ),
          Text(
            name,
            style: Styles.textStyle34.copyWith(
              fontFamily: kfontFamily,
              color: kMainColor,
            ),
          ),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: kMainColor,
            ),
            child: const Icon(
              Icons.favorite_border,
              color: Colors.white,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
