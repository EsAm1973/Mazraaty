import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mazraaty/Core/data/Cubits/User%20Cubit/user_cubit.dart';
import 'package:mazraaty/Core/widgets/dialog_helper.dart';
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
    // التحقق من النقاط قبل البدء
    final userCubit = context.read<UserCubit>();
    final currentUser = userCubit.currentUser;
    if (currentUser == null || currentUser.points < 10) {
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
      // تنفيذ التنبؤ
      await scanCubit.makePrediction(file);

      // عند نجاح التنبؤ، جلب تفاصيل المرض
      if (scanCubit.state.diseaseName.isNotEmpty) {
        print('User points: ${currentUser.points}');
        await _fetchDiseaseDetails(context, scanCubit.state.diseaseName);
        // خصم 10 نقاط بعد الكشف الناجح
        _deductPoints(context);
      }
    } catch (e) {
      _handleError(context, 'Failed to capture image: ${e.toString()}');
    } finally {
      _isProcessing = false;
    }
  }

  Future<void> pickImage(BuildContext context) async {
    // التحقق من النقاط قبل البدء
    final userCubit = context.read<UserCubit>();
    final currentUser = userCubit.currentUser;
    if (currentUser == null || currentUser.points < 10) {
      print('User points: ${currentUser?.points}');
      DialogHelper.showSubscriptionDialog(context);
      return;
    }

    if (_isProcessing) return;
    _isProcessing = true;
    final scanCubit = context.read<ScanCubit>();

    try {
      scanCubit.reset();
      final XFile? file = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );

      if (file != null) {
        // تنفيذ التنبؤ
        await scanCubit.makePrediction(file);

        // عند نجاح التنبؤ، جلب تفاصيل المرض
        if (scanCubit.state.diseaseName.isNotEmpty) {
          print('User points: ${currentUser.points}');
          await _fetchDiseaseDetails(context, scanCubit.state.diseaseName);
          // خصم 10 نقاط بعد الكشف الناجح
          _deductPoints(context);
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

  // دالة لخصم 10 نقاط من المستخدم
  void _deductPoints(BuildContext context) {
    final userCubit = context.read<UserCubit>();
    final currentUser = userCubit.currentUser;
    if (currentUser != null) {
      final updatedUser = currentUser.copyWith(
        points: currentUser.points - 10,
      );
      userCubit.saveUser(updatedUser); // سيؤدي إلى emit حالة جديدة
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
