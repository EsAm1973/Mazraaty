import 'package:flutter/material.dart';
import 'package:mazraaty/constants.dart';

class LibraryPlantsGridItemButtomSection extends StatelessWidget {
  const LibraryPlantsGridItemButtomSection(
      {super.key, required this.description});
  final String description;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Color(0xFFD0E2B6),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 40),
            child: Text(
              description,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 11,
                color: Colors.black87,
              ),
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: InkWell(
              onTap: () {},
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: kMainColor,
                ),
                child: const Icon(
                  Icons.favorite_border,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
