import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mazraaty/Features/scan_plant/data/repos/scan_repo.dart';
import 'scan_state.dart';

class ScanCubit extends Cubit<ScanState> {
  final ScanRepository repository;

  ScanCubit({required this.repository}) : super(const ScanState());

  Future<void> pickImage() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile == null) {
        emit(state.copyWith(error: 'No image selected'));
        return;
      }

      // Read file bytes for preview
      final bytes = await pickedFile.readAsBytes();
      emit(state.copyWith(imageBytes: bytes, error: ''));

      // Make prediction
      await processImage(pickedFile);
    } catch (e) {
      emit(state.copyWith(error: 'Error picking image: ${e.toString()}'));
    }
  }

  /// تعالج الصورة من الكاميرا أو المعرض
  Future<void> processImage(XFile file) async {
    await makePrediction(file);
  }

  /// تعيد حالة التطبيق إلى الوضع الافتراضي
  void reset() {
    emit(const ScanState());
  }

  Future<void> makePrediction(XFile file) async {
    try {
      emit(state.copyWith(isLoading: true));
      final predictionModel = await repository.predictDisease(file);

      emit(state.copyWith(
        diseaseName: predictionModel.diseaseName, // اسم المرض فقط
        confidence: predictionModel.confidence, // النسبة فقط
        isLoading: false,
        error: '',
      ));
    } catch (e) {
      emit(state.copyWith(
        error: 'Prediction error: ${e.toString()}',
        isLoading: false,
      ));
    }
  }
}
