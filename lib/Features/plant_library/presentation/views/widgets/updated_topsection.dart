import 'package:flutter/material.dart';

class UpdatedDetailsTopSection extends StatelessWidget {
  const UpdatedDetailsTopSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/images/details_test.png',
          width: double.infinity,
          height: 350,
          fit: BoxFit.cover,
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
        )
      ],
    );
  }
}
