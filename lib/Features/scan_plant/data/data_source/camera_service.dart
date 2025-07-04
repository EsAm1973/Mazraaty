import 'package:camera/camera.dart';

class CameraService {
  CameraController? _cameraController;
  bool _isInitialized = false;
  final ResolutionPreset _resolution = ResolutionPreset.medium;

  Future<void> initializeCamera() async {
    // If already initialized but disposed, reset the flag
    if (_isInitialized && _cameraController?.value.isInitialized == false) {
      _isInitialized = false;
      _cameraController = null;
    }

    if (_isInitialized) return;

    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) throw Exception('No cameras found');

      _cameraController = CameraController(
        cameras.first,
        _resolution,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );

      await _cameraController!.initialize();
      _isInitialized = true;
    } catch (e) {
      _isInitialized = false;
      throw Exception('Camera initialization failed: $e');
    }
  }

  Future<void> disposeCamera() async {
    if (!_isInitialized || _cameraController == null) return;

    try {
      await _cameraController!.dispose();
    } catch (e) {
      print('Error disposing camera: $e');
    } finally {
      _cameraController = null;
      _isInitialized = false;
    }
  }

  CameraController? get cameraController =>
      _isInitialized && _cameraController?.value.isInitialized == true
          ? _cameraController
          : null;
}
