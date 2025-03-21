import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DiseaseTopImage extends StatelessWidget {
  const DiseaseTopImage({super.key, required this.image});
  final Uint8List image;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.memory(
          image,
          width: double.infinity,
          height: 350,
          fit: BoxFit.fill,
        ),
        Positioned(
          top: 20,
          left: 20,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200.withOpacity(0.7),
              borderRadius: BorderRadius.circular(50),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        Positioned(
          top: 20,
          right: 20,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200.withOpacity(0.7),
              borderRadius: BorderRadius.circular(50),
            ),
            child: IconButton(
              icon: const Icon(
                FontAwesomeIcons.download,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
          ),
        ),
      ],
    );
  }
}
