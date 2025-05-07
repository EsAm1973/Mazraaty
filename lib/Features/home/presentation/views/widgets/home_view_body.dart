import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mazraaty/Core/utils/app_router.dart';
import 'package:mazraaty/Features/home/presentation/views/widgets/home_app_features.dart';
import 'package:mazraaty/Features/home/presentation/views/widgets/home_community_section.dart';
import 'package:mazraaty/Features/home/presentation/views/widgets/home_plant_issuelist.dart';
import 'package:mazraaty/Features/home/presentation/views/widgets/home_premium_card.dart';
import 'package:mazraaty/Features/home/presentation/views/widgets/home_user_points.dart';
import 'package:mazraaty/Features/home/presentation/views/widgets/home_weather_card.dart';
import 'package:mazraaty/Features/home/presentation/views/widgets/home_welcome_card.dart';
import 'package:mazraaty/constants.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _floatingButtonController;
  late ScrollController _scrollController;

  // Animations for each widget
  late Animation<double> _fadeInAnimation;
  late Animation<double> _floatingButtonAnimation;

  bool _showFloatingButton = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    // Main animation controller for content
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeInAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );

    // Floating button animation controller
    _floatingButtonController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _floatingButtonAnimation = CurvedAnimation(
      parent: _floatingButtonController,
      curve: Curves.easeOut,
    );

    // Listen to scroll events to show/hide floating button
    _scrollController.addListener(_onScroll);

    _animationController.forward();
  }

  void _onScroll() {
    // Show floating button when scrolled down
    if (_scrollController.offset > 300 && !_showFloatingButton) {
      setState(() {
        _showFloatingButton = true;
        _floatingButtonController.forward();
      });
    } else if (_scrollController.offset <= 300 && _showFloatingButton) {
      setState(() {
        _showFloatingButton = false;
        _floatingButtonController.reverse();
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _floatingButtonController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Main content
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: FadeTransition(
            opacity: _fadeInAnimation,
            child: CustomScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              slivers: [
                // Add some space at the top
                const SliverToBoxAdapter(child: SizedBox(height: 10)),

                // Welcome Card
                SliverToBoxAdapter(
                  child: AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return Transform.translate(
                        offset:
                            Offset(0, (1 - _animationController.value) * 20),
                        child: child,
                      );
                    },
                    child: const HomeWelcomeCard(),
                  ),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 20)),

                // Scan Credits Widget
                SliverToBoxAdapter(
                  child: AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return Transform.translate(
                        offset:
                            Offset(0, (1 - _animationController.value) * 25),
                        child: child,
                      );
                    },
                    child: HomePointWidegt(onHowToEarnTap: () {}),
                  ),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 20)),

                // Common Diseases
                SliverToBoxAdapter(
                  child: AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return Transform.translate(
                        offset:
                            Offset(0, (1 - _animationController.value) * 30),
                        child: child,
                      );
                    },
                    child: const HomeRecentPlantIssue(),
                  ),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 20)),

                // Weather Card
                SliverToBoxAdapter(
                  child: AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return Transform.translate(
                        offset:
                            Offset(0, (1 - _animationController.value) * 35),
                        child: child,
                      );
                    },
                    child: const HomeWeatherCard(),
                  ),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 30)),

                // Community Website Section
                SliverToBoxAdapter(
                  child: AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return Transform.translate(
                        offset:
                            Offset(0, (1 - _animationController.value) * 40),
                        child: child,
                      );
                    },
                    child: const HomeCommunitySection(),
                  ),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 30)),

                // App Features Section
                SliverToBoxAdapter(
                  child: AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return Transform.translate(
                        offset:
                            Offset(0, (1 - _animationController.value) * 45),
                        child: child,
                      );
                    },
                    child: const HomeAppFeatures(),
                  ),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 20)),

                // Premium Upgrade Card
                SliverToBoxAdapter(
                  child: AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return Transform.translate(
                        offset:
                            Offset(0, (1 - _animationController.value) * 50),
                        child: child,
                      );
                    },
                    child: HomePremiumUpgradeCard(onSubscribeTap: () {
                      // Navigate to payment methods view
                      GoRouter.of(context).push(AppRouter.kPaymentPackgesView);
                    }),
                  ),
                ),

                // Add some space at the bottom
                const SliverToBoxAdapter(child: SizedBox(height: 30)),
              ],
            ),
          ),
        ),

        // Floating action button to scroll to top
        Positioned(
          bottom: 20,
          right: 20,
          child: ScaleTransition(
            scale: _floatingButtonAnimation,
            child: FloatingActionButton(
              onPressed: () {
                _scrollController.animateTo(
                  0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeOutQuad,
                );
              },
              backgroundColor: kMainColor,
              elevation: 4,
              mini: true,
              child: const Icon(
                Icons.arrow_upward,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
