import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mazraaty/Core/data/Cubits/User%20Cubit/user_cubit.dart';
import 'package:mazraaty/Features/home/data/repos/weather_repo_impl.dart';
import 'package:mazraaty/Features/home/presentation/manager/Weather%20Cubit/weather_cubit.dart';
import 'package:mazraaty/Features/home/presentation/views/widgets/home_view_body.dart';
import 'package:mazraaty/Features/profile/presentation/manager/Profile/profile_cubit.dart';
import 'package:mazraaty/constants.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with WidgetsBindingObserver {
  bool _isFirstLoad = true;

  @override
  void initState() {
    super.initState();
    // Register this object as an observer to detect when the app comes to the foreground
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Only refresh on first load to avoid excessive API calls
    if (_isFirstLoad) {
      _isFirstLoad = false;

      // Schedule the refresh for the next frame to ensure all providers are ready
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _refreshProfileData();
      });
    }
  }

  @override
  void dispose() {
    // Unregister the observer when the widget is disposed
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Refresh profile data when the app comes to the foreground
    if (state == AppLifecycleState.resumed) {
      _refreshProfileData();
    }
  }

  // Method to refresh profile data
  void _refreshProfileData() {
    if (context.mounted) {
      final profileCubit = context.read<ProfileCubit>();
      final userCubit = context.read<UserCubit>();
      if (userCubit.currentUser != null) {
        profileCubit.fetchProfile(token: userCubit.currentUser!.token);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final weatherCubit = WeatherCubit(
          WeatherRepositoryImpl(
            Dio(),
          ),
        );

        // Fetch weather data for Alexandria
        weatherCubit.getWeather('Alexandria');

        return weatherCubit;
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                kScaffoldColor,
                Color.alphaBlend(kScaffoldColor.withAlpha(242), Colors.white),
                Colors.white.withAlpha(230),
              ],
              stops: const [0.0, 0.6, 1.0],
            ),
          ),
          child: SafeArea(
            child: RefreshIndicator(
              onRefresh: () async {
                // Refresh profile data when the user pulls down to refresh
                _refreshProfileData();
              },
              child: const HomeViewBody(),
            ),
          ),
        ),
      ),
    );
  }
}
