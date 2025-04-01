import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:camera/camera.dart';
import 'package:mazraaty/Core/widgets/dialog_helper.dart';
import 'package:mazraaty/Features/scan_plant/presentation/manager/Disease%20Details/disease_details_cubit.dart';
import 'package:mazraaty/Features/scan_plant/presentation/manager/Points%20Cubit/cubit/points_cubit.dart';
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

    // Initialize controller with both cubits
    _scanController = ScanController(
      diseaseDetailsCubit: context.read<DiseaseDetailsCubit>(),
      pointsCubit: context.read<PointsCubit>(),
    );

    _scanController.onCameraInitialized = () {
      if (mounted) {
        setState(() => _isCameraActive = true);
      }
    };

    _initializeCamera();

    // Refresh points when view is created
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _scanController.refreshPoints(context);
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _scanController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused) {
      _scanController.stopCamera();
      _isCameraActive = false;
    } else if (state == AppLifecycleState.resumed) {
      _initializeCamera();
      // Refresh points when app is resumed
      _scanController.refreshPoints(context);
    }
  }

  Future<void> _initializeCamera() async {
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      if (!_isCameraActive) {
        await _scanController.startCamera();
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
      builder: (context) {
        if (detailsState is DiseaseDetailLoaded) {
          if (scanState.imageBytes == null) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              padding: const EdgeInsets.all(20),
              child: const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.image_not_supported,
                        size: 64, color: Colors.grey),
                    SizedBox(height: 16),
                    Text(
                      'No image available',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            );
          }
          return DiseaseBottomSheetWidget(
            details: detailsState.details,
            confidance: scanState.confidence,
            imageBytes: scanState.imageBytes!,
          );
        } else if (detailsState is DiseaseDetailError) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error_outline,
                      size: 64, color: Colors.redAccent),
                  const SizedBox(height: 16),
                  const Text(
                    'Error',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    detailsState.message,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        }
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: const EdgeInsets.all(20),
          child: const Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 48,
                  height: 48,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(kMainColor),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Loading details...',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        );
      },
    ).then((_) {
      _isBottomSheetOpen = false;
      // Re-check camera status when bottom sheet is closed
      _ensureCameraActive();
    });
  }

  // New method to ensure camera is active
  Future<void> _ensureCameraActive() async {
    if (!_isCameraActive && mounted) {
      await _initializeCamera();
    } else if (_isCameraActive &&
        _scanController.cameraService.cameraController?.value.isInitialized !=
            true) {
      // Camera marked as active but controller is not initialized
      _isCameraActive = false;
      if (mounted) {
        await _initializeCamera();
      }
    }
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
              // Ensure camera is active when loading finishes
              _ensureCameraActive();
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
              // Ensure camera is active after errors
              _ensureCameraActive();
            }

            // عرض النتائج عند نجاح الجلب
            if (detailsState is DiseaseDetailLoaded) {
              final scanState = context.read<ScanCubit>().state;
              if (scanState.imageBytes != null) {
                _showBottomSheet(context, detailsState, scanState);
              }
            }
          },
        ),
      ],
      child: Stack(
        children: [
          // Background color
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFFE4F0E5),
            ),
          ),

          Column(
            children: [
              // Camera preview area
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 40.0, 16.0, 16.0),
                  child: Center(
                    child: AspectRatio(
                      aspectRatio:
                          3 / 4, // More portrait format for plant photos
                      child: BlocBuilder<ScanCubit, ScanState>(
                        buildWhen: (prev, current) =>
                            prev.imageBytes != current.imageBytes,
                        builder: (context, state) {
                          // Camera loading or error states
                          if (!_isCameraActive) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              if (mounted && !_isCameraActive) {
                                _initializeCamera();
                              }
                            });
                            return const Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    width: 48,
                                    height: 48,
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          kMainColor),
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    'Initializing camera...',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }

                          final cameraController =
                              _scanController.cameraService.cameraController;
                          final isInitialized =
                              cameraController?.value.isInitialized == true;

                          if (!isInitialized && _isCameraActive) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              if (mounted) {
                                setState(() => _isCameraActive = false);
                                _initializeCamera();
                              }
                            });
                            return const Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    width: 48,
                                    height: 48,
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          kMainColor),
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    'Preparing camera...',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }

                          // Camera preview with enhanced styling
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(
                                color: Colors.white,
                                width: 4,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.15),
                                  blurRadius: 8,
                                  spreadRadius: 1,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(24),
                              child: isInitialized
                                  ? Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        // Camera preview
                                        CameraPreview(cameraController!),

                                        // Scanning overlay
                                        Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color:
                                                  kMainColor.withOpacity(0.5),
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(24),
                                          ),
                                        ),

                                        // Optional: Subtle guide lines
                                        Positioned.fill(
                                          child: CustomPaint(
                                            painter: GuidelinesPainter(),
                                          ),
                                        ),

                                        // Scanning indicator at corners
                                        Positioned(
                                          top: 16,
                                          left: 16,
                                          child: _buildCornerIndicator(),
                                        ),
                                        Positioned(
                                          top: 16,
                                          right: 16,
                                          child: _buildCornerIndicator(),
                                        ),
                                        Positioned(
                                          bottom: 16,
                                          left: 16,
                                          child: _buildCornerIndicator(),
                                        ),
                                        Positioned(
                                          bottom: 16,
                                          right: 16,
                                          child: _buildCornerIndicator(),
                                        ),

                                        // Scanning instructions
                                        Positioned(
                                          bottom: 16,
                                          left: 0,
                                          right: 0,
                                          child: Center(
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 16,
                                                vertical: 6,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.black
                                                    .withOpacity(0.6),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: const Text(
                                                'Position plant in frame',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Center(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.camera_alt_outlined,
                                            size: 64,
                                            color: Colors.grey[400],
                                          ),
                                          const SizedBox(height: 16),
                                          Text(
                                            'Camera Not Available',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),

              // Camera controls
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(28)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 6,
                      offset: const Offset(0, -2),
                    )
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Gallery button
                    _buildControlButton(
                      icon: Icons.image_rounded,
                      label: 'Gallery',
                      onPressed: () => _scanController.pickImage(context),
                      iconColor: Colors.blue[600]!,
                      backgroundColor: Colors.blue[50]!,
                    ),

                    // Camera capture button
                    GestureDetector(
                      onTap: () => _scanController.captureImage(context),
                      child: Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: kMainColor,
                          boxShadow: [
                            BoxShadow(
                              color: kMainColor.withOpacity(0.25),
                              blurRadius: 8,
                              spreadRadius: 2,
                            ),
                          ],
                          border: Border.all(
                            color: Colors.white,
                            width: 3,
                          ),
                        ),
                        child: const Icon(
                          Icons.camera_alt_rounded,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),

                    // Help button
                    _buildControlButton(
                      icon: Icons.help_outline_rounded,
                      label: 'Help',
                      onPressed: () => _showHelpDialog(context),
                      iconColor: Colors.amber[700]!,
                      backgroundColor: Colors.amber[50]!,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Corner indicator for the scanning frame
  Widget _buildCornerIndicator() {
    return Container(
      width: 18,
      height: 18,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(3),
        border: Border.all(
          color: kMainColor,
          width: 3,
        ),
      ),
    );
  }

  // Control button for gallery and help
  Widget _buildControlButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    required Color iconColor,
    required Color backgroundColor,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: backgroundColor,
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 24,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  // Show help dialog
  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        elevation: 8,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: kMainColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.tips_and_updates,
                        color: kMainColor, size: 24),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Text(
                      'How to Scan Plants',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(Icons.close,
                        color: Colors.black45, size: 20),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              Divider(
                  height: 1, thickness: 1, color: Colors.grey.withOpacity(0.2)),
              const SizedBox(height: 20),

              // Instructions
              _buildHelpItem(
                '1',
                'Position your plant in the frame',
                Icons.crop_free_rounded,
              ),
              const SizedBox(height: 16),
              _buildHelpItem(
                '2',
                'Make sure there is good lighting',
                Icons.wb_sunny_outlined,
              ),
              const SizedBox(height: 16),
              _buildHelpItem(
                '3',
                'Hold the camera steady',
                Icons.pan_tool_outlined,
              ),
              const SizedBox(height: 16),
              _buildHelpItem(
                '4',
                'Tap the green button to capture',
                Icons.camera_alt_rounded,
              ),

              const SizedBox(height: 24),

              // Points information
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.amber[50],
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.amber[100]!),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.star_rounded,
                      color: Colors.amber[700],
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Each scan costs 10 points',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.amber[800],
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Action button
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: kMainColor,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text(
                  'Got it',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Help item with icon
  Widget _buildHelpItem(String number, String text, IconData icon) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    Icon(icon, size: 20, color: kMainColor.withOpacity(0.8)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        text,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Custom painter for subtle guidelines
class GuidelinesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.15)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    // Draw grid lines
    final cellSize = size.width / 3;

    // Vertical lines
    for (int i = 1; i < 3; i++) {
      final x = cellSize * i;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    // Horizontal lines
    final cellSizeH = size.height / 3;
    for (int i = 1; i < 3; i++) {
      final y = cellSizeH * i;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
