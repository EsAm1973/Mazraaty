import 'package:flutter/material.dart';
import 'package:mazraaty/Features/onboardeing/presentation/views/widgets/onboardbuildscreen.dart';
import 'package:mazraaty/Features/onboardeing/presentation/views/widgets/progress_dots.dart';
import 'package:mazraaty/Features/onboardeing/presentation/views/widgets/skip_button.dart';
import 'package:mazraaty/constants.dart';

class OnboardingViewBody extends StatefulWidget {
  const OnboardingViewBody({super.key});

  @override
  _OnboardingViewBodyState createState() => _OnboardingViewBodyState();
}

class _OnboardingViewBodyState extends State<OnboardingViewBody> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              itemCount: onboardingData.length,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              itemBuilder: (_, index) {
                return OnboardingPage(
                  title: onboardingData[index]['title']!,
                  subtitle: onboardingData[index]['subtitle']!,
                  imagePath: onboardingData[index]['image']!,
                );
              },
            ),
            SkipButton(pageController: _pageController),
            ProgressDots(
                currentPage: _currentPage, pageController: _pageController),
          ],
        ),
      ),
    );
  }
}
