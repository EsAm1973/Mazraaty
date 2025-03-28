import 'package:camera/camera.dart';

class CameraService {
  CameraController? _cameraController;
  bool _isInitialized = false;
  final ResolutionPreset _resolution = ResolutionPreset.medium;

  Future<void> initializeCamera() async {
    if (_isInitialized) return;

    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) throw Exception('No cameras found');

      _cameraController = CameraController(
        cameras.first,
        _resolution,
        enableAudio: false,
      );

      await _cameraController!.initialize();
      _isInitialized = true;
    } catch (e) {
      _isInitialized = false;
      throw Exception('Camera initialization failed: $e');
    }
  }

  Future<void> disposeCamera() async {
    if (!_isInitialized) return;

    await _cameraController?.dispose();
    _cameraController = null;
    _isInitialized = false;
  }

  CameraController? get cameraController =>
      _isInitialized ? _cameraController : null;
}
