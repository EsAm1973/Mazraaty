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
      await makePrediction(pickedFile);
    } catch (e) {
      emit(state.copyWith(error: 'Error picking image: ${e.toString()}'));
    }
  }

  Future<void> makePrediction(XFile file) async {
    try {
      emit(state.copyWith(isLoading: true));
      final predictionModel = await repository.predictDisease(file);
      final predString =
          '${predictionModel.disease} (${(predictionModel.confidence * 100).toStringAsFixed(1)}%)';
      emit(state.copyWith(prediction: predString, isLoading: false, error: ''));
    } catch (e) {
      emit(state.copyWith(
          error: 'Prediction error: ${e.toString()}', isLoading: false));
    }
  }
}
