import 'package:image_picker/image_picker.dart';
import 'package:mazraaty/Features/scan_plant/data/models/prediction.dart';

abstract class ScanRepository {
  Future<PredictionModel> predictDisease(XFile file);
}
