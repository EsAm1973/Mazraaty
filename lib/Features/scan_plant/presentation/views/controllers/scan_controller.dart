import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mazraaty/Features/scan_plant/data/data_source/camera_service.dart';
import 'package:mazraaty/Features/scan_plant/presentation/manager/Scan/scan_cubit.dart';

class ScanController {
  final CameraService _cameraService = CameraService();
  bool _isProcessing = false;
  VoidCallback? onCameraInitialized;

  CameraController? get cameraController => _cameraService.cameraController;

  Future<void> initializeCamera() async {
    await _cameraService.initializeCamera();
    onCameraInitialized?.call();
  }

  Future<void> captureImage(BuildContext context) async {
    if (_isProcessing ||
        cameraController == null ||
        !cameraController!.value.isInitialized) return;

    _isProcessing = true;
    final cubit = context.read<ScanCubit>();

    try {
      cubit.reset();
      final XFile file = await cameraController!.takePicture();
      await cubit.makePrediction(file);
    } catch (e) {
      _handleError(context, 'Failed to capture image: ${e.toString()}');
    } finally {
      _isProcessing = false;
    }
  }

  Future<void> pickImage(BuildContext context) async {
    if (_isProcessing) return;
    _isProcessing = true;
    final cubit = context.read<ScanCubit>();

    try {
      cubit.reset();
      final XFile? file = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );

      if (file != null) {
        await cubit.makePrediction(file);
      }
    } catch (e) {
      _handleError(context, 'Failed to pick image: ${e.toString()}');
    } finally {
      _isProcessing = false;
    }
  }

  void _handleError(BuildContext context, String message) {
    final cubit = context.read<ScanCubit>();
    cubit.emit(cubit.state.copyWith(
      error: message,
      isLoading: false,
    ));
  }

  void dispose() {
    _cameraService.disposeCamera();
    _isProcessing = false;
  }
}
