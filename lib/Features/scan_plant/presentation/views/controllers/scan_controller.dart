import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mazraaty/Features/scan_plant/data/data_source/camera_service.dart';
import 'package:mazraaty/Features/scan_plant/presentation/manager/Disease%20Details/disease_details_cubit.dart';
import 'package:mazraaty/Features/scan_plant/presentation/manager/Scan/scan_cubit.dart';

class ScanController {
  final CameraService _cameraService = CameraService();
  final DiseaseDetailsCubit _diseaseDetailsCubit;
  bool _isProcessing = false;
  VoidCallback? onCameraInitialized;

  ScanController({required DiseaseDetailsCubit diseaseDetailsCubit})
      : _diseaseDetailsCubit = diseaseDetailsCubit;

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
      // Step 1: عمل التنبؤ
      await cubit.makePrediction(file);

      // Step 2: إذا كان التنبؤ ناجح، جلب التفاصيل
      if (cubit.state.diseaseName.isNotEmpty) {
        await _fetchDiseaseDetails(context, cubit.state.diseaseName);
      }
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
        // Step 1: عمل التنبؤ
        await cubit.makePrediction(file);

        // Step 2: إذا كان التنبؤ ناجح، جلب التفاصيل
        if (cubit.state.diseaseName.isNotEmpty) {
          await _fetchDiseaseDetails(context, cubit.state.diseaseName);
        }
      }
    } catch (e) {
      _handleError(context, 'Failed to pick image: ${e.toString()}');
    } finally {
      _isProcessing = false;
    }
  }

  Future<void> _fetchDiseaseDetails(
      BuildContext context, String diseaseName) async {
    try {
      await _diseaseDetailsCubit.getDiseaseDetails(diseaseName);
    } catch (e) {
      print('Error fetching details: ${e.toString()}');
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
