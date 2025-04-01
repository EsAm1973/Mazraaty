import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mazraaty/Core/data/Cubits/User%20Cubit/user_cubit.dart';
import 'package:mazraaty/Core/widgets/dialog_helper.dart';
import 'package:mazraaty/Features/scan_plant/data/data_source/camera_service.dart';
import 'package:mazraaty/Features/scan_plant/presentation/manager/Disease%20Details/disease_details_cubit.dart';
import 'package:mazraaty/Features/scan_plant/presentation/manager/Points%20Cubit/cubit/points_cubit.dart';
import 'package:mazraaty/Features/scan_plant/presentation/manager/Scan/scan_cubit.dart';

class ScanController {
  final CameraService _cameraService = CameraService();
  final DiseaseDetailsCubit _diseaseDetailsCubit;
  final PointsCubit _pointsCubit;
  bool _isProcessing = false;
  VoidCallback? onCameraInitialized;

  // Cost of scanning a plant
  static const int SCAN_COST = 10;

  ScanController({
    required DiseaseDetailsCubit diseaseDetailsCubit,
    required PointsCubit pointsCubit,
  })  : _diseaseDetailsCubit = diseaseDetailsCubit,
        _pointsCubit = pointsCubit;

  CameraService get cameraService => _cameraService;
  CameraController? get cameraController => _cameraService.cameraController;

  Future<void> startCamera() async {
    try {
      await _cameraService.initializeCamera();
      onCameraInitialized?.call();
    } catch (e) {
      print('Camera Error: $e');
    }
  }

  Future<void> stopCamera() async => await _cameraService.disposeCamera();

  Future<void> initializeCamera() async {
    await _cameraService.initializeCamera();
    onCameraInitialized?.call();
  }

  /// Refreshes user points from the API
  Future<void> refreshPoints(BuildContext context) async {
    final userCubit = context.read<UserCubit>();
    if (userCubit.currentUser != null) {
      await _pointsCubit.fetchUserPoints(userCubit.currentUser!.token);
    }
  }

  /// Checks if user has enough points for scanning
  bool _hasEnoughPoints(BuildContext context) {
    // First check PointsCubit state which should be most up-to-date
    if (_pointsCubit.state is PointsLoaded) {
      final points = (_pointsCubit.state as PointsLoaded).points.points;
      return points >= SCAN_COST;
    }

    // Fallback to UserCubit
    final userCubit = context.read<UserCubit>();
    final currentUser = userCubit.currentUser;
    return currentUser != null && currentUser.points >= SCAN_COST;
  }

  Future<void> captureImage(BuildContext context) async {
    // Refresh points from API first
    await refreshPoints(context);

    // Check if user has enough points after refresh
    if (!_hasEnoughPoints(context)) {
      DialogHelper.showSubscriptionDialog(context);
      return;
    }

    if (_isProcessing ||
        cameraController == null ||
        !cameraController!.value.isInitialized) return;

    _isProcessing = true;
    final scanCubit = context.read<ScanCubit>();

    try {
      scanCubit.reset();
      final XFile file = await cameraController!.takePicture();
      await scanCubit.makePrediction(file);

      if (scanCubit.state.diseaseName.isNotEmpty) {
        await _fetchDiseaseDetails(context, scanCubit.state.diseaseName);
        // Refresh points after the operation to get updated balance
        await refreshPoints(context);
      }
    } catch (e) {
      _handleError(context, 'Failed to capture image: ${e.toString()}');
    } finally {
      _isProcessing = false;
    }
  }

  Future<void> pickImage(BuildContext context) async {
    // Refresh points from API first
    await refreshPoints(context);

    // Check if user has enough points after refresh
    if (!_hasEnoughPoints(context)) {
      DialogHelper.showSubscriptionDialog(context);
      return;
    }

    if (_isProcessing) return;
    _isProcessing = true;
    final scanCubit = context.read<ScanCubit>();

    try {
      scanCubit.reset();

      // Temporarily stop the camera before accessing gallery
      final bool wasCameraActive =
          _cameraService.cameraController?.value.isInitialized ?? false;
      if (wasCameraActive) {
        await stopCamera();
      }

      final XFile? file = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );

      // Restart the camera regardless of result
      if (wasCameraActive) {
        await startCamera();
      }

      if (file != null) {
        await scanCubit.makePrediction(file);

        if (scanCubit.state.diseaseName.isNotEmpty) {
          await _fetchDiseaseDetails(context, scanCubit.state.diseaseName);
          // Refresh points after the operation to get updated balance
          await refreshPoints(context);
        }
      }
    } catch (e) {
      _handleError(context, 'Failed to pick image: ${e.toString()}');
      // Ensure camera is restarted even if there's an error
      await startCamera();
    } finally {
      _isProcessing = false;
    }
  }

  Future<void> _fetchDiseaseDetails(
      BuildContext context, String diseaseName) async {
    final userCubit = context.read<UserCubit>();
    try {
      await _diseaseDetailsCubit.getDiseaseDetails(
          diseaseName, userCubit.currentUser!.token);
    } catch (e) {
      print('Error fetching details: ${e.toString()}');
    }
  }

  void _handleError(BuildContext context, String message) {
    final scanCubit = context.read<ScanCubit>();
    scanCubit.emit(scanCubit.state.copyWith(
      error: message,
      isLoading: false,
    ));
  }

  void dispose() {
    _cameraService.disposeCamera();
    _isProcessing = false;
  }
}
