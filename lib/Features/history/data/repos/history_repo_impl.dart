import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mazraaty/Core/errors/failure.dart';
import 'package:mazraaty/Core/utils/api_service.dart';
import 'package:mazraaty/Features/history/data/models/history_model.dart';
import 'package:mazraaty/Features/history/data/repos/history_repo.dart';
import 'package:mazraaty/Features/scan_plant/data/models/disease_details.dart';

class HistoryRepositoryImpl implements IHistoryRepository {
  final ApiService _apiService;

  HistoryRepositoryImpl({required ApiService apiService})
      : _apiService = apiService;

  @override
  Future<Either<Failure, SaveDiseaseResponse>> addDiseaseToHistory(
      DiseaseDetailsModel disease, Uint8List imageBytes, String token) async {
    try {
      // Prepare the request with FormData for multipart/form-data
      final formData = FormData();

      // Add disease_id
      formData.fields.add(MapEntry('disease_id', disease.id.toString()));

      // Add image file
      final multipartFile = MultipartFile.fromBytes(
        imageBytes,
        filename: 'disease_image.jpg',
        contentType: MediaType('image', 'jpeg'),
      );
      formData.files.add(MapEntry('image', multipartFile));

      // Set headers with authorization token
      final headers = {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      };

      // Make the API request
      final response = await _apiService.post(
        'save-disease',
        formData,
        headers: headers,
      );

      final saveResponse = SaveDiseaseResponse.fromJson(response);
      return Right(saveResponse);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<HistoryDisease>>> getHistory(String token) async {
    try {
      // Set headers with authorization token
      final headers = {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      };

      // Make the API request
      final response = await _apiService.get(
        'history',
        headers: headers,
      );

      final historyResponse = HistoryResponse.fromJson(response);
      return Right(historyResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }
}
