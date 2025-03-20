import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mazraaty/Features/scan_plant/data/repos/Scan%20Repo/scan_repo.dart';
import 'scan_state.dart';

class ScanCubit extends Cubit<ScanState> {
  final ScanRepository repository;

  ScanCubit({required this.repository}) : super(const ScanState());

  Future<void> pickImage() async {
    try {
      // إعادة تعيين الحالة قبل البدء
      emit(const ScanState(isLoading: true));

      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile == null) {
        emit(state.copyWith(error: 'No image selected', isLoading: false));
        return;
      }

      final bytes = await pickedFile.readAsBytes();
      emit(state.copyWith(
        imageBytes: bytes,
        diseaseName: '',
        confidence: 0.0,
        isLoading: true,
        error: '',
      ));

      await processImage(pickedFile);
    } catch (e) {
      emit(state.copyWith(
          error: 'Error picking image: ${e.toString()}', isLoading: false));
    }
  }

  Future<void> processImage(XFile file) async {
    emit(state.copyWith(isLoading: true));
    await makePrediction(file);
  }

  /// تعيد حالة التطبيق إلى الوضع الافتراضي
  void reset() {
    emit(const ScanState(
      diseaseName: '',
      confidence: 0.0,
      isLoading: false,
      error: '',
    ));
  }

  Future<void> makePrediction(XFile file) async {
    try {
      emit(state.copyWith(isLoading: true, error: '')); // بدء التحميل

      final prediction = await repository.predictDisease(file);

      emit(state.copyWith(
        diseaseName: prediction.diseaseName,
        confidence: prediction.confidence,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        error: 'Prediction failed: ${e.toString()}',
        isLoading: false,
      ));
    }
  }
}
