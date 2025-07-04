import 'package:image_picker/image_picker.dart';
import 'package:mazraaty/Features/scan_plant/data/data_source/api_scan_service.dart';
import 'package:mazraaty/Features/scan_plant/data/models/prediction.dart';
import 'package:mazraaty/Features/scan_plant/data/repos/Scan%20Repo/scan_repo.dart';

class ScanRepositoryImpl implements ScanRepository {
  final ApiScanService apiScanService;

  ScanRepositoryImpl({required this.apiScanService});

  @override
  Future<PredictionModel> predictDisease(XFile file) async {
    final data = await apiScanService.predictDisease(file);
    return PredictionModel.fromJson(data);
  }
}
