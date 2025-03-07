import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mazraaty/Features/profile/presentation/views/widgets/crop_image_view_body.dart';

class CropImageView extends StatelessWidget {
  const CropImageView({super.key, required this.imageFile});
  final File imageFile;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CropImageViewBody(
        imageFile: imageFile,
      ),
    );
  }
}
