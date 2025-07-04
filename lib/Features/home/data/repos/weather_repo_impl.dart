import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mazraaty/Core/errors/failure.dart';
import 'package:mazraaty/Features/home/data/models/weather_model.dart';
import 'package:mazraaty/Features/home/data/repos/weather_repo.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final Dio _dio;
  //final LocationService _locationService;
  final String _apiKey = 'dce1390fc9d5c4aeaeb8a4168b9e580d';
  final String _baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  WeatherRepositoryImpl(this._dio);

  @override
  Future<Either<Failure, WeatherModel>> getWeather(String city) async {
    try {
      final response = await _dio.get(
        _baseUrl,
        queryParameters: {
          'q': city,
          'appid': _apiKey,
          'units': 'metric', // Add units parameter for Celsius
        },
      );

      final weatherModel = WeatherModel.fromJson(response.data);
      return Right(weatherModel);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }

  // @override
  // Future<Either<Failure, WeatherModel>> getWeatherByLocation() async {
  //   try {
  //     final position = await _locationService.getCurrentLocation();

  //     if (position == null) {
  //       return Left(ServerFailure(
  //         errorMessage: 'Location services are disabled or permission denied',
  //       ));
  //     }

  //     final response = await _dio.get(
  //       _baseUrl,
  //       queryParameters: {
  //         'lat': position.latitude,
  //         'lon': position.longitude,
  //         'appid': _apiKey,
  //         'units': 'metric', // Add units parameter for Celsius
  //       },
  //     );

  //     final weatherModel = WeatherModel.fromJson(response.data);
  //     return Right(weatherModel);
  //   } on DioException catch (e) {
  //     return Left(ServerFailure.fromDioException(e));
  //   } catch (e) {
  //     return Left(ServerFailure(errorMessage: e.toString()));
  //   }
  // }
}
