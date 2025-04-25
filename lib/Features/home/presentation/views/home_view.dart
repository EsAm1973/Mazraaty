import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mazraaty/Features/home/data/repos/weather_repo_impl.dart';
import 'package:mazraaty/Features/home/presentation/manager/Weather%20Cubit/weather_cubit.dart';
import 'package:mazraaty/Features/home/presentation/views/widgets/home_view_body.dart';
import 'package:mazraaty/constants.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final weatherCubit = WeatherCubit(
          WeatherRepositoryImpl(
            Dio(),
          ),
        );

        // Fetch weather data for Alexandria
        weatherCubit.getWeather('Alexandria');

        return weatherCubit;
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                kScaffoldColor,
                Color.alphaBlend(kScaffoldColor.withAlpha(242), Colors.white),
                Colors.white.withAlpha(230),
              ],
              stops: const [0.0, 0.6, 1.0],
            ),
          ),
          child: const SafeArea(
            child: HomeViewBody(),
          ),
        ),
      ),
    );
  }
}
