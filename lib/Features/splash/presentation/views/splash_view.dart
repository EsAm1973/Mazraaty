import 'package:flutter/material.dart';
import 'package:mazraaty/Features/splash/presentation/views/widgets/splash_view_body.dart';
import 'package:mazraaty/constants.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        backgroundColor: kMainColor,
        body: SplashViewBody(),
      ),
    );
  }
}
