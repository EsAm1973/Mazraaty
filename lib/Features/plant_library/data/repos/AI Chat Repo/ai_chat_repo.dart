import 'package:dartz/dartz.dart';
import 'package:mazraaty/Core/errors/failure.dart';
import 'package:mazraaty/Features/plant_library/data/models/ai_chat_response.dart';

abstract class AIChatRepo {
  Future<Either<Failure, AIChatResponse>> sendMessage(String message);
  Future<Either<Failure, AIChatResponse>> getPlantDetails(String plantName);
}