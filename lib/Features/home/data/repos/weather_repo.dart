import 'package:dartz/dartz.dart';
import 'package:mazraaty/Core/errors/failure.dart';
import 'package:mazraaty/Features/home/data/models/weather_model.dart';

abstract class WeatherRepository {
  Future<Either<Failure, WeatherModel>> getWeather(String city);
 // Future<Either<Failure, WeatherModel>> getWeatherByLocation();
}