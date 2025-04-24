import 'package:flutter/material.dart';
import 'package:mazraaty/Features/home/presentation/views/widgets/home_view_body.dart';
import 'package:mazraaty/constants.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: Scaffold(
          backgroundColor: kScaffoldColor,
      body: HomeViewBody(),
    ));
  }
}
