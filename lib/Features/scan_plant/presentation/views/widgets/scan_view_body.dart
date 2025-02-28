import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:camera/camera.dart';
import 'package:mazraaty/Features/scan_plant/presentation/manager/Scan/scan_cubit.dart';
import 'package:mazraaty/Features/scan_plant/presentation/manager/Scan/scan_state.dart';
import 'package:mazraaty/Features/scan_plant/presentation/views/controllers/scan_controller.dart';
import 'package:mazraaty/Features/scan_plant/presentation/views/widgets/buttom_sheet.dart';
import 'package:mazraaty/constants.dart';

class ScanViewBody extends StatefulWidget {
  const ScanViewBody({super.key});

  @override
  _ScanViewBodyState createState() => _ScanViewBodyState();
}

class _ScanViewBodyState extends State<ScanViewBody> {
  final ScanController _scanController = ScanController();
  bool _isBottomSheetOpen = false;

  @override
  void initState() {
    super.initState();
    _scanController.onCameraInitialized = () {
      if (mounted) {
        setState(() {});
      }
    };
    _scanController.initializeCamera();
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
      builder: (context) => BottomSheetWidget(state: state),
    ).whenComplete(() {
      _isBottomSheetOpen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  child: _scanController.cameraController != null &&
                          _scanController.cameraController!.value.isInitialized
                      ? CameraPreview(_scanController.cameraController!)
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
                    icon: const Icon(Icons.image, color: Colors.grey, size: 32),
                    onPressed: () => _scanController.pickImage(context),
                  ),
                  FloatingActionButton(
                    backgroundColor: Colors.green,
                    child: const Icon(Icons.camera, color: Colors.white),
                    onPressed: () => _scanController.captureImage(context),
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
