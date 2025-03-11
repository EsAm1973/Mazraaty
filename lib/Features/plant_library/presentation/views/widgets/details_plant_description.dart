import 'package:flutter/material.dart';
import 'package:mazraaty/Core/utils/styles.dart';
import 'package:mazraaty/constants.dart';

class DetailsDescriptionPlant extends StatelessWidget {
  const DetailsDescriptionPlant(
      {super.key, required this.description, required this.name});
  final String name;
  final String description;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 30),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            name,
            style: Styles.textStyle30.copyWith(fontFamily: kfontFamily),
          ),
          Expanded(
            child: Text(description,style: Styles.textStyle16,),
          ),
        ]),
      ),
    );
  }
}
