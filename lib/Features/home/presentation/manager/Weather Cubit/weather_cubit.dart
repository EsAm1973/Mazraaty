import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mazraaty/Features/home/data/models/weather_model.dart';
import 'package:mazraaty/Features/home/data/repos/weather_repo.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepository _weatherRepository;

  WeatherCubit(this._weatherRepository) : super(WeatherInitial());

  Future<void> getWeather(String city) async {
    emit(WeatherLoading());

    final result = await _weatherRepository.getWeather(city);

    result.fold(
      (failure) => emit(WeatherError(failure.errorMessage)),
      (weather) => emit(WeatherLoaded(weather)),
    );
  }

  // Future<void> getWeatherByLocation() async {
  //   emit(WeatherLoading());

  //   final result = await _weatherRepository.getWeatherByLocation();

  //   result.fold(
  //     (failure) => emit(WeatherError(failure.errorMessage)),
  //     (weather) => emit(WeatherLoaded(weather)),
  //   );
  // }
}
