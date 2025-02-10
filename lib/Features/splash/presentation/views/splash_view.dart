import 'package:flutter/material.dart';
import 'package:mazraaty/Features/splash/presentation/views/widgets/splash_view_body.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff3E7B27),
        body: SplashViewBody(),
      ),
    );
  }
}
