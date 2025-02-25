import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:camera/camera.dart';
import 'package:mazraaty/Features/scan_plant/data/data_source/camera_service.dart';
import 'package:mazraaty/Features/scan_plant/presentation/manager/Scan/scan_cubit.dart';
import 'package:mazraaty/Features/scan_plant/presentation/manager/Scan/scan_state.dart';
import 'package:mazraaty/constants.dart';

class ScanViewBody extends StatefulWidget {
  const ScanViewBody({super.key});

  @override
  _ScanViewBodyState createState() => _ScanViewBodyState();
}

class _ScanViewBodyState extends State<ScanViewBody> {
  final CameraService _cameraService = CameraService();
  bool _isBottomSheetOpen = false; // ✅ متغير لتتبع حالة الـ Bottom Sheet

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    await _cameraService.initializeCamera();
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _captureImage(BuildContext context) async {
    final cameraController = _cameraService.cameraController;
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }
    final XFile file = await cameraController.takePicture();
    context.read<ScanCubit>().makePrediction(file);
  }

  Future<void> _pickImage(BuildContext context) async {
    final XFile? file =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file != null) {
      context.read<ScanCubit>().makePrediction(file);
    }
  }

  void _showBottomSheet(BuildContext context, ScanState state) {
    if (_isBottomSheetOpen) return;
    _isBottomSheetOpen = true;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              state.diseaseName,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            ),
            const SizedBox(height: 8),
            Text(
              'Confidence: ${(state.confidence * 100).toStringAsFixed(1)}%',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/diseaseDetails'),
              child: const Text('Read More'),
            ),
          ],
        ),
      ),
    ).whenComplete(() {
      _isBottomSheetOpen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cameraController = _cameraService.cameraController;

    return BlocConsumer<ScanCubit, ScanState>(
      listener: (context, state) {
        if (state.diseaseName.isNotEmpty) {
          _showBottomSheet(context, state);
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: cameraController != null &&
                          cameraController.value.isInitialized
                      ? CameraPreview(cameraController)
                      : const Center(child: CircularProgressIndicator()),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: const BoxDecoration(
                color: kScaffoldColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(Icons.image, color: Colors.grey[800], size: 32),
                    onPressed: () => _pickImage(context),
                  ),
                  FloatingActionButton(
                    backgroundColor: Colors.green,
                    child: const Icon(Icons.camera, color: Colors.white),
                    onPressed: () => _captureImage(context),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
