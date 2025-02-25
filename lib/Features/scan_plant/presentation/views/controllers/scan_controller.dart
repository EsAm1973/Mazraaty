import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mazraaty/Features/scan_plant/data/data_source/camera_service.dart';
import 'package:mazraaty/Features/scan_plant/presentation/manager/Scan/scan_cubit.dart';

class ScanController {
  final CameraService _cameraService = CameraService();
  VoidCallback? onCameraInitialized; // دالة لإعادة البناء بعد التهيئة

  CameraController? get cameraController => _cameraService.cameraController;

  Future<void> initializeCamera() async {
    await _cameraService.initializeCamera();
    onCameraInitialized?.call(); // إعادة البناء بعد التهيئة
  }

  Future<void> captureImage(BuildContext context) async {
    if (cameraController == null || !cameraController!.value.isInitialized) {
      return;
    }
    final XFile file = await cameraController!.takePicture();
    context.read<ScanCubit>().makePrediction(file);
  }

  Future<void> pickImage(BuildContext context) async {
    final XFile? file =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file != null) {
      context.read<ScanCubit>().makePrediction(file);
    }
  }

  void dispose() {
    _cameraService.disposeCamera();
  }
}
