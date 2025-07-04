import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:mazraaty/constants.dart';

class CropImageViewBody extends StatefulWidget {
  const CropImageViewBody({super.key, required this.imageFile});
  final File imageFile;

  @override
  State<CropImageViewBody> createState() => _CropImageViewBodyState();
}

class _CropImageViewBodyState extends State<CropImageViewBody> {
  File? _croppedFile;

  @override
  void initState() {
    super.initState();
    _cropImage();
  }

  Future<void> _cropImage() async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: widget.imageFile.path,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: kMainColor,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9,
          ],
        ),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );

    if (croppedFile != null) {
      setState(() {
        _croppedFile = File(croppedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Photo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              GoRouter.of(context).pop(_croppedFile ?? widget.imageFile);
            },
          ),
        ],
      ),
      body: Center(
        child: _croppedFile != null
            ? Image.file(_croppedFile!)
            : Image.file(widget.imageFile),
      ),
    );
  }
}
