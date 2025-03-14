// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:mazraaty/Features/plant_library/data/models/plant.dart';
// import 'package:mazraaty/Features/plant_library/presentation/views/widgets/details_appbar.dart';
// import 'package:mazraaty/Features/plant_library/presentation/views/widgets/details_plant_description.dart';
// import 'package:mazraaty/Features/plant_library/presentation/views/widgets/details_plantdetails.dart';

// class DetailsViewBody extends StatelessWidget {
//   const DetailsViewBody({super.key, required this.plant});
//   final Plant plant;
//   @override
//   Widget build(BuildContext context) {
//     const fullUrlImage = 'https://6ca1-197-121-146-72.ngrok-free.app/storage/';
//     return LayoutBuilder(builder: (context, constraints) {
//       final halfHeight = constraints.maxHeight / 2;
//       return Stack(
//         children: [
//           Column(
//             children: [
//               SizedBox(
//                 height: halfHeight,
//                 child: SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       DetailsCustomAppBar(
//                         name: plant.name,
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                       ),
//                       DetailsOfPlant(
//                         plant: plant,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: halfHeight,
//                 child: DetailsDescriptionPlant(
//                   name: plant.name,
//                   description: plant.description,
//                 ),
//               ),
//             ],
//           ),
//           Positioned(
//             right: 20,
//             top: halfHeight - 50,
//             child: CachedNetworkImage(
//               height: 120,
//               width: 120,
//               imageUrl: fullUrlImage + plant.image,
//               errorWidget: (context, url, error) => const Icon(
//                 Icons.error,
//               ),
//               placeholder: (context, url) => const Center(
//                 child: CircularProgressIndicator(
//                   color: Colors.black,
//                 ),
//               ),
//             ),
//           )
//         ],
//       );
//     });
//   }
// }
