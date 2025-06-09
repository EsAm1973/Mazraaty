import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mazraaty/Core/data/Cubits/User%20Cubit/user_cubit.dart';
import 'package:mazraaty/Core/utils/styles.dart';
import 'package:mazraaty/Features/scan_plant/presentation/manager/Points%20Cubit/cubit/points_cubit.dart';
import 'package:mazraaty/Features/scan_plant/presentation/views/widgets/scan_view_body.dart';
import 'package:mazraaty/constants.dart';

class ScanView extends StatefulWidget {
  const ScanView({super.key});

  @override
  State<ScanView> createState() => _ScanViewState();
}

class _ScanViewState extends State<ScanView> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _refreshPoints();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Refresh points when app is resumed
      _refreshPoints();
    }
  }

  // Fetch fresh points from API
  void _refreshPoints() {
    final userCubit = context.read<UserCubit>();
    final pointsCubit = context.read<PointsCubit>();

    if (userCubit.currentUser != null) {
      pointsCubit.fetchUserPoints(userCubit.currentUser!.token);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: SafeArea(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: Colors.white.withOpacity(0.7),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                )
              ],
            ),
            child: AppBar(
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(
                'Scan Plant',
                style: Styles.textStyle26.copyWith(
                  fontFamily: kfontFamily,
                  color: kMainColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: Container(
                margin: const EdgeInsets.only(left: 8.0),
                child: BlocBuilder<PointsCubit, PointsState>(
                  builder: (context, state) {
                    Widget child;
                    if (state is PointsLoaded) {
                      child = Flexible(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.star_rounded,
                              color: Colors.amber[700],
                              size: 16,
                            ),
                            const SizedBox(width: 2),
                            Flexible(
                              child: Text(
                                '${state.points.points}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.amber[800],
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      );
                    } else if (state is PointsLoading) {
                      child = const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: kMainColor,
                        ),
                      );
                    } else {
                      // Fallback to user points
                      final userCubit = context.watch<UserCubit>();
                      if (userCubit.currentUser != null) {
                        child = Flexible(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.star_rounded,
                                color: Colors.amber[700],
                                size: 16,
                              ),
                              const SizedBox(width: 2),
                              Flexible(
                                child: Text(
                                  '${userCubit.currentUser!.points}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.amber[800],
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        child = const SizedBox.shrink();
                      }
                    }
                    return Center(child: child);
                  },
                ),
              ),
              actions: [
                Container(
                  margin: const EdgeInsets.only(right: 8.0),
                  child: IconButton(
                    icon: const Icon(Icons.refresh, color: kMainColor),
                    onPressed: _refreshPoints,
                    tooltip: 'Refresh Points',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFE4F0E5),
        ),
        child: const ScanViewBody(),
      ),
    );
  }
}
