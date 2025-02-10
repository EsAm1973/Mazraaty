import 'package:flutter/material.dart';
import 'package:mazraaty/Features/onboardeing/presentation/views/widgets/screen1_view_body.dart';

class OnboardScreensView extends StatelessWidget {
  const OnboardScreensView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: Scaffold(
      body: OnboardingViewBody(),
    ));
  }
}
