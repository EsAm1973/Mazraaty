// دالة لضغط الصورة
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

Future<Uint8List> compressImage(Uint8List imageBytes) async {
  final compressedBytes = await FlutterImageCompress.compressWithList(
    imageBytes,
    minWidth: 800,
    minHeight: 600,
    quality: 70,
    format: CompressFormat.jpeg,
  );
  return compressedBytes;
}

// دالة لحفظ الصورة في النظام وإرجاع مسارها
Future<String> saveImageFile(Uint8List imageBytes, int diseaseId, int userId) async {
  final directory = await getApplicationDocumentsDirectory();
  final String fileName = 'disease_${userId}_$diseaseId.jpg';
  final String filePath = join(directory.path, fileName);
  final file = File(filePath);
  await file.writeAsBytes(imageBytes);
  return filePath;
}
