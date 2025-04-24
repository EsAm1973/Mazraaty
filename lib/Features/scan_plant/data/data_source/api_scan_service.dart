import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

class ApiScanService {
  final Dio dio;

  ApiScanService({Dio? dio}) : dio = dio ?? Dio();

  Future<Map<String, dynamic>> predictDisease(XFile file) async {
    const String url = 'http://10.0.2.2:5000/predict';

    // Determine MIME type
    final mimeType = lookupMimeType(file.path) ?? 'image/jpeg';
    final mediaType = MediaType.parse(mimeType);

    // Create a MultipartFile using Dio
    final multipartFile = await MultipartFile.fromFile(
      file.path,
      filename: file.name,
      contentType: mediaType,
    );

    final formData = FormData.fromMap({
      'image': multipartFile,
    });

    final response = await dio.post(url, data: formData);

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('Prediction failed: ${response.statusMessage}');
    }
  }
}
