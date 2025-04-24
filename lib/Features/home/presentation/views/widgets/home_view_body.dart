import 'package:flutter/material.dart';
import 'package:mazraaty/Features/home/presentation/views/widgets/home_premium_card.dart';
import 'package:mazraaty/Features/home/presentation/views/widgets/home_user_points.dart';
import 'package:mazraaty/Features/home/presentation/views/widgets/home_welcome_card.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
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
        ],
      ),
    );
  }
}