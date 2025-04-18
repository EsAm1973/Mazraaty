import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UpdatedDetailsTopSection extends StatelessWidget {
  const UpdatedDetailsTopSection({super.key, required this.imageUrl});
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CachedNetworkImage(
          height: 350,
          imageUrl: imageUrl,
          width: double.infinity,
          errorWidget: (context, url, error) => const Icon(
            Icons.error,
          ),
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          ),
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
