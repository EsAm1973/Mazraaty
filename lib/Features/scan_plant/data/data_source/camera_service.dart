import 'package:camera/camera.dart';

class CameraService {
  static final CameraService _instance = CameraService._internal();
  factory CameraService() => _instance;

  CameraController? _cameraController;
  List<CameraDescription>? _cameras;

  CameraService._internal();

  Future<void> initializeCamera() async {
    if (_cameraController != null) return; // إذا كانت الكاميرا مهيئة، لا تفعل شيئًا

    _cameras = await availableCameras();
    if (_cameras != null && _cameras!.isNotEmpty) {
      _cameraController = CameraController(_cameras![0], ResolutionPreset.medium);
      await _cameraController!.initialize();
    }
  }

  CameraController? get cameraController => _cameraController;

  void disposeCamera() {
    _cameraController?.dispose();
    _cameraController = null;
  }
}
