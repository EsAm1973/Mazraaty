// import 'package:flutter/material.dart';
// import 'package:mazraaty/Core/utils/styles.dart';
// import 'package:mazraaty/Features/plant_library/data/models/plant.dart';
// import 'package:mazraaty/constants.dart';

// class DetailsOfPlant extends StatelessWidget {
//   const DetailsOfPlant({super.key, required this.plant});
//   final Plant plant;
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 27, vertical: 15),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Light',
//             style: Styles.textStyle18.copyWith(
//               color: const Color(0xFF7E7E7E),
//             ),
//           ),
//           Text(
//             plant.sunlightAmount,
//             style: Styles.textStyle20.copyWith(
//               color: kMainColor,
//             ),
//           ),
//           const SizedBox(
//             height: 3,
//           ),
//           Text(
//             'Soil',
//             style: Styles.textStyle18.copyWith(
//               color: const Color(0xFF7E7E7E),
//             ),
//           ),
//           Text(
//             plant.soil,
//             style: Styles.textStyle20.copyWith(
//               color: kMainColor,
//             ),
//           ),
//           const SizedBox(
//             height: 3,
//           ),
//           Text(
//             'Water',
//             style: Styles.textStyle18.copyWith(
//               color: const Color(0xFF7E7E7E),
//             ),
//           ),
//           Text(
//             plant.wateringAmount,
//             style: Styles.textStyle20.copyWith(
//               color: kMainColor,
//             ),
//           ),
//           const SizedBox(
//             height: 3,
//           ),
//           Text(
//             'Air',
//             style: Styles.textStyle18.copyWith(
//               color: const Color(0xFF7E7E7E),
//             ),
//           ),
//           Text(
//             'Requires good circulation',
//             style: Styles.textStyle20.copyWith(
//               color: kMainColor,
//             ),
//           ),
//           const SizedBox(
//             height: 3,
//           ),
//           Text(
//             'Temperature',
//             style: Styles.textStyle18.copyWith(
//               color: const Color(0xFF7E7E7E),
//             ),
//           ),
//           Text(
//             plant.temperatureRange,
//             style: Styles.textStyle20.copyWith(
//               color: kMainColor,
//             ),
//           ),
//           const SizedBox(
//             height: 3,
//           ),
//           Text(
//             'Nutrients',
//             style: Styles.textStyle18.copyWith(
//               color: const Color(0xFF7E7E7E),
//             ),
//           ),
//           SizedBox(
//             width: MediaQuery.of(context).size.width * 2 / 3,
//             child: Text(
//               softWrap: true,
//               plant.nutrients,
//               style: Styles.textStyle20.copyWith(
//                 color: kMainColor,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
