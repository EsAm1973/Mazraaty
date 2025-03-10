import 'package:flutter/material.dart';
import 'package:mazraaty/Core/utils/styles.dart';
import 'package:mazraaty/constants.dart';

class DetailsOfPlant extends StatelessWidget {
  const DetailsOfPlant({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 27, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Light',
            style: Styles.textStyle18.copyWith(
              color: const Color(0xFF7E7E7E),
            ),
          ),
          Text(
            'Full Sun',
            style: Styles.textStyle20.copyWith(
              color: kMainColor,
            ),
          ),
          const SizedBox(
            height: 3,
          ),
          Text(
            'Soil',
            style: Styles.textStyle18.copyWith(
              color: const Color(0xFF7E7E7E),
            ),
          ),
          Text(
            'Well-drained Loamy Soil',
            style: Styles.textStyle20.copyWith(
              color: kMainColor,
            ),
          ),
          const SizedBox(
            height: 3,
          ),
          Text(
            'Water',
            style: Styles.textStyle18.copyWith(
              color: const Color(0xFF7E7E7E),
            ),
          ),
          Text(
            'Regular, keep moist',
            style: Styles.textStyle20.copyWith(
              color: kMainColor,
            ),
          ),
          const SizedBox(
            height: 3,
          ),
          Text(
            'Air',
            style: Styles.textStyle18.copyWith(
              color: const Color(0xFF7E7E7E),
            ),
          ),
          Text(
            'Requires good circulation',
            style: Styles.textStyle20.copyWith(
              color: kMainColor,
            ),
          ),
          const SizedBox(
            height: 3,
          ),
          Text(
            'Temperature',
            style: Styles.textStyle18.copyWith(
              color: const Color(0xFF7E7E7E),
            ),
          ),
          Text(
            '70-85°F',
            style: Styles.textStyle20.copyWith(
              color: kMainColor,
            ),
          ),
          const SizedBox(
            height: 3,
          ),
          Text(
            'Nutrients',
            style: Styles.textStyle18.copyWith(
              color: const Color(0xFF7E7E7E),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 2 / 3,
            child: Text(
              softWrap: true,
              'High in nitrogen and potassium',
              style: Styles.textStyle20.copyWith(
                color: kMainColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
