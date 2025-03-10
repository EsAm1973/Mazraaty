import 'package:flutter/material.dart';
import 'package:mazraaty/Core/utils/styles.dart';
import 'package:mazraaty/constants.dart';

class DetailsDescriptionPlant extends StatelessWidget {
  const DetailsDescriptionPlant({super.key});

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
            'Tomato',
            style: Styles.textStyle30.copyWith(fontFamily: kfontFamily),
          ),
          Expanded(
            child: Text(
              'The tomato is a popular fruit, scientifically known as Solanum lycopersicum, often classified as a vegetable in culinary terms. It is native to western South America but is now grown globally. Tomatoes are rich in nutrients, including vitamin C, potassium, and antioxidants like lycopene, which is known for its cancer-fighting properties. Tomatoes are versatile and are used in a wide variety of dishes, such as salads, sauces, soups, and juices, contributing both flavor and nutritional value.',
              style: Styles.textStyle16.copyWith(color: kMainColor),
            ),
          ),
        ]),
      ),
    );
  }
}
