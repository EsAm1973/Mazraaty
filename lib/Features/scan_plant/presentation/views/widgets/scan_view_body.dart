import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:camera/camera.dart';
import 'package:mazraaty/Core/widgets/dialog_helper.dart';
import 'package:mazraaty/Features/scan_plant/presentation/manager/Disease%20Details/disease_details_cubit.dart';
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

class _ScanViewBodyState extends State<ScanViewBody>
    with WidgetsBindingObserver, AutomaticKeepAliveClientMixin {
  late ScanController _scanController;
  bool _isCameraActive = false;
  bool _isBottomSheetOpen = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    // إضافة التهيئة هنا ↓
    _scanController = ScanController(
      diseaseDetailsCubit: context.read<DiseaseDetailsCubit>(),
    );

    _initializeCamera();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    if (_scanController.cameraService.cameraController != null) {
      _scanController.stopCamera();
    }
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _scanController.stopCamera();
    } else if (state == AppLifecycleState.resumed) {
      _initializeCamera();
    }
  }

  Future<void> _initializeCamera() async {
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      if (!_isCameraActive) {
        await _scanController.startCamera();
        if (mounted) {
          setState(() => _isCameraActive = true);
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isCameraActive = false);
      }
      print('Camera Initialization Error: $e');
    }
  }

  void _showBottomSheet(
    BuildContext context,
    DiseaseDetailsState detailsState,
    ScanState scanState,
  ) {
    if (_isBottomSheetOpen) {
      Navigator.of(context).pop();
    }
    _isBottomSheetOpen = true;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        if (detailsState is DiseaseDetailLoaded) {
          if (scanState.imageBytes == null) {
            return const Center(child: Text('No image available'));
          }
          return DiseaseBottomSheetWidget(
            details: detailsState.details,
            confidance: scanState.confidence,
            imageBytes: scanState.imageBytes!,
          );
        } else if (detailsState is DiseaseDetailError) {
          return Center(child: Text(detailsState.message));
        }
        return const Center(child: CircularProgressIndicator());
      },
    ).then((_) => _isBottomSheetOpen = false);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MultiBlocListener(
      listeners: [
        BlocListener<ScanCubit, ScanState>(
          listener: (context, scanState) {
            // إدارة حالة التحميل والأخطاء الخاصة بالمسح
            if (scanState.isLoading) {
              DialogHelper.showLoading(context);
            } else {
              DialogHelper.hideLoading();
            }

            if (scanState.error.isNotEmpty) {
              DialogHelper.showError(
                context,
                'Error scanning',
                scanState.error,
              );
            }
          },
        ),
        BlocListener<DiseaseDetailsCubit, DiseaseDetailsState>(
          listener: (context, detailsState) {
            // إدارة أخطاء تفاصيل المرض
            if (detailsState is DiseaseDetailError) {
              DialogHelper.showError(
                context,
                'Error getting details',
                detailsState.message,
              );
            }

            // عرض النتائج عند نجاح الجلب
            if (detailsState is DiseaseDetailLoaded) {
              final scanState = context.read<ScanCubit>().state;
              print(scanState.imageBytes!.length);
              _showBottomSheet(context, detailsState, scanState);
            }
          },
        ),
      ],
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: BlocBuilder<ScanCubit, ScanState>(
                buildWhen: (prev, current) =>
                    prev.imageBytes != current.imageBytes,
                builder: (context, state) {
                  if (!_isCameraActive) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: _scanController.cameraService.cameraController?.value
                                .isInitialized ==
                            true
                        ? CameraPreview(
                            _scanController.cameraService.cameraController!)
                        : const Center(child: Text('Camera Not Available')),
                  );
                },
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
      ),
    );
  }
}
