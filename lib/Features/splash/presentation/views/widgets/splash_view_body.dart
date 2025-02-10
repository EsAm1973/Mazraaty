import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mazraaty/Core/utils/app_router.dart';
import 'package:mazraaty/Core/utils/styles.dart';
import 'package:mazraaty/constants.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  double _opacirty = 0.0;
  @override
  void initState() {
    super.initState();
    _animatedOpacity();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedText(),
    );
  }

  AnimatedOpacity AnimatedText() {
    return AnimatedOpacity(
      duration: const Duration(seconds: 1),
      opacity: _opacirty,
      curve: Curves.easeInOut,
      child: Text(
        'Mazraaty',
        style: Styles.textStyle50.copyWith(
          color: Colors.white,
          fontFamily: kfontFamily,
        ),
      ),
    );
  }

  void _animatedOpacity() {
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _opacirty = 1.0;
      });
      Future.delayed(const Duration(seconds: 2), () {
        GoRouter.of(context).pushReplacement(AppRouter.kOnboardingView);
      });
    });
  }
}
