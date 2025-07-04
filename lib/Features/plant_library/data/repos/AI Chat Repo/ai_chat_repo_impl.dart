import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mazraaty/Core/errors/failure.dart';
import 'package:mazraaty/Features/plant_library/data/models/ai_chat_response.dart';
import 'package:mazraaty/Features/plant_library/data/repos/AI%20Chat%20Repo/ai_chat_repo.dart';
import 'package:mazraaty/Features/plant_library/data/services/ai_chat_service.dart';

class AIChatRepoImpl implements AIChatRepo {
  final AIChatService aiChatService;

  AIChatRepoImpl(this.aiChatService);

  @override
  Future<Either<Failure, AIChatResponse>> sendMessage(String message) async {
    try {
      final response = await aiChatService.sendChatRequest(message);

      // Check if response is in the new format or old format
      if (response.data is Map<String, dynamic> &&
          response.data.containsKey('message') &&
          response.data.containsKey('isUser')) {
        // New format - direct AIChatResponse data
        return Right(AIChatResponse(
          message: response.data['message'],
          isUser: response.data['isUser'],
          timestamp: response.data['timestamp'] != null
              ? DateTime.parse(response.data['timestamp'])
              : DateTime.now(),
        ));
      } else {
        // Old format
        return Right(AIChatResponse.fromJson(response.data));
      }
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AIChatResponse>> getPlantDetails(
      String plantName) async {
    try {
      final prompt =
          "Can you help me with some questions about the $plantName plant?";
      final response = await aiChatService.sendChatRequest(prompt);

      // Check if response is in the new format or old format
      if (response.data is Map<String, dynamic> &&
          response.data.containsKey('message') &&
          response.data.containsKey('isUser')) {
        // New format - direct AIChatResponse data
        return Right(AIChatResponse(
          message: response.data['message'],
          isUser: response.data['isUser'],
          timestamp: response.data['timestamp'] != null
              ? DateTime.parse(response.data['timestamp'])
              : DateTime.now(),
        ));
      } else {
        // Old format
        return Right(AIChatResponse.fromJson(response.data));
      }
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }
}
