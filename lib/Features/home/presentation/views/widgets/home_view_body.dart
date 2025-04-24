import 'package:flutter/material.dart';
import 'package:mazraaty/Core/utils/styles.dart';
import 'package:mazraaty/Features/home/presentation/views/widgets/home_plant_issuelist.dart';
import 'package:mazraaty/Features/home/presentation/views/widgets/home_premium_card.dart';
import 'package:mazraaty/Features/home/presentation/views/widgets/home_user_points.dart';
import 'package:mazraaty/Features/home/presentation/views/widgets/home_weather_card.dart';
import 'package:mazraaty/Features/home/presentation/views/widgets/home_welcome_card.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const HomeWelcomeCard(),
            const SizedBox(
              height: 20,
            ),
            HomePointWidegt(points: 120, onHowToEarnTap: () {}),
            const SizedBox(
              height: 20,
            ),
            HomePremiumUpgradeCard(onSubscribeTap: () {}),
            const SizedBox(
              height: 20,
            ),
            const HomeRecentPlantIssue(),
            const SizedBox(
              height: 10,
            ),
            const HomeWeatherCard(
              temperature: 25.5,
              weatherCondition: 'Sunny',
              humidity: '60',
              uvIndex: 'Moderate',
              sunsetTime: '6:30 PM',
            ),
          ],
        ),
      ),
    );
  }
}