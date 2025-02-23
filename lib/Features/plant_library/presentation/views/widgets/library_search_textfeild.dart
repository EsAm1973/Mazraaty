import 'package:flutter/material.dart';
import 'package:mazraaty/Core/utils/styles.dart';

class LibrarySearchTextFeild extends StatelessWidget {
  const LibrarySearchTextFeild({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 0,
            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.transparent,
          hintText: 'Search',
          hintStyle:
              Styles.textStyle16.copyWith(color: const Color(0xFFCFCFCF)),
          prefixIcon: const Icon(
            Icons.search,
            color: Color(0xFFCFCFCF),
            size: 28,
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }
}
