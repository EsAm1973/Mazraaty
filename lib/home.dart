import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Uint8List? imageBytes;
  String? prediction;
  bool isLoading = false;

  Future<void> getImage() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile == null) {
        showSnackBar('No image selected');
        return;
      }

      // Read file bytes for preview
      final bytes = await pickedFile.readAsBytes();
      setState(() => imageBytes = bytes);

      // Make prediction with file path
      await makePrediction(pickedFile);
    } catch (e) {
      showSnackBar('Error picking image: ${e.toString()}');
    }
  }

  Future<void> makePrediction(XFile file) async {
    setState(() => isLoading = true);

    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('http://10.0.2.2:5000/predict'),
      );

      // Add the image file with proper headers (matches PHP implementation)
      final mimeType = lookupMimeType(file.path) ?? 'image/jpeg';
      final filePart = await http.MultipartFile.fromPath(
        'image', // Field name must match PHP server expectation
        file.path,
        filename: file.name,
        contentType: MediaType.parse(mimeType),
      );

      request.files.add(filePart);

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      print('Response status: ${response.statusCode}');
      print('Response body: $responseBody');

      if (response.statusCode == 200) {
        final result = json.decode(responseBody);
        setState(() {
          prediction = result['disease'] ?? 'No prediction available';
          if (result['confidence'] != null) {
            prediction =
                '$prediction (${(result['confidence'] * 100).toStringAsFixed(1)}%)';
          }
        });
      } else {
        showSnackBar('Prediction failed: ${response.reasonPhrase}');
      }
    } catch (e) {
      showSnackBar('Prediction error: ${e.toString()}');
      print('Error during prediction: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  void showSnackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plant Disease Detector'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (imageBytes != null)
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.memory(imageBytes!, fit: BoxFit.contain),
                        ),
                      ),
                    ),
                  if (isLoading)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: CircularProgressIndicator(),
                    ),
                  if (prediction != null && !isLoading)
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        prediction!,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  if (imageBytes == null && !isLoading)
                    const Expanded(
                      child: Center(
                        child: Text(
                          'Select an image to analyze',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              icon: const Icon(Icons.photo_library),
              label: const Text('CHOOSE IMAGE'),
              onPressed: isLoading ? null : getImage,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
