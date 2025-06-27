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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mazraaty/Features/scan_plant/presentation/manager/Points Cubit/cubit/points_cubit.dart';

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

  late Animation<double> _fadeInAnimation;
  late Animation<double> _floatingButtonAnimation;

  bool _showFloatingButton = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeInAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );

    _floatingButtonController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _floatingButtonAnimation = CurvedAnimation(
      parent: _floatingButtonController,
      curve: Curves.easeOut,
    );

    _scrollController.addListener(_onScroll);
    _animationController.forward().then((_) {
      _animationController.stop();
    });
  }

  void _onScroll() {
    final bool shouldShow = _scrollController.offset > 300;
    if (shouldShow != _showFloatingButton) {
      _showFloatingButton = shouldShow;
      if (shouldShow) {
        _floatingButtonController.forward();
      } else {
        _floatingButtonController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _floatingButtonController.dispose();
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: FadeTransition(
            opacity: _fadeInAnimation,
            child: CustomScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              slivers: [
                const SliverToBoxAdapter(child: SizedBox(height: 10)),
                _buildAnimatedWidget(const HomeWelcomeCard(), 20),
                const SliverToBoxAdapter(child: SizedBox(height: 20)),
                _buildPointsWidget(),
                const SliverToBoxAdapter(child: SizedBox(height: 20)),
                _buildAnimatedWidget(const HomeRecentPlantIssue(), 30),
                const SliverToBoxAdapter(child: SizedBox(height: 20)),
                _buildAnimatedWidget(const HomeWeatherCard(), 35),
                const SliverToBoxAdapter(child: SizedBox(height: 30)),
                _buildAnimatedWidget(const HomeCommunitySection(), 40),
                const SliverToBoxAdapter(child: SizedBox(height: 30)),
                _buildAnimatedWidget(const HomeAppFeatures(), 45),
                const SliverToBoxAdapter(child: SizedBox(height: 20)),
                _buildAnimatedWidget(
                  HomePremiumUpgradeCard(onSubscribeTap: () {
                    GoRouter.of(context).push(AppRouter.kPaymentPackgesView);
                  }),
                  50,
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 30)),
              ],
            ),
          ),
        ),
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

  Widget _buildAnimatedWidget(Widget child, double offsetFactor) {
    return SliverToBoxAdapter(
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, _) {
          return Transform.translate(
            offset: Offset(0, (1 - _animationController.value) * offsetFactor),
            child: child,
          );
        },
      ),
    );
  }

  Widget _buildPointsWidget() {
    return _buildAnimatedWidget(
      BlocBuilder<PointsCubit, PointsState>(
        buildWhen: (previous, current) => current is! PointsLoading,
        builder: (context, state) {
          if (state is PointsLoaded) {
            return HomePointWidegt(
              points: state.points,
              onHowToEarnTap: () {},
            );
          } else if (state is PointsError) {
            return Text('Error loading points: ${state.message}');
          }
          return const SizedBox.shrink();
        },
      ),
      25,
    );
  }
}
