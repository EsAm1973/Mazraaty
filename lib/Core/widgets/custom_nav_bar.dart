import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mazraaty/Core/data/Cubits/User%20Cubit/user_cubit.dart';
import 'package:mazraaty/Features/history/presentation/manager/History/history_cubit.dart';
import 'package:mazraaty/Features/history/presentation/views/history_view.dart';
import 'package:mazraaty/Features/home/presentation/manager/Common%20Disease%20Cubit/common_disease_cubit.dart';
import 'package:mazraaty/Features/home/presentation/views/home_view.dart';
import 'package:mazraaty/Features/plant_library/presentation/views/library_view.dart';
import 'package:mazraaty/Features/profile/presentation/manager/Profile/profile_cubit.dart';
import 'package:mazraaty/Features/profile/presentation/views/profile_view.dart';
import 'package:mazraaty/Features/scan_plant/presentation/views/scan_view.dart';
import 'package:mazraaty/constants.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({super.key});

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  int selectedIndex = 0;

  final List<Widget> pages = [
    const HomeView(),
    const LibraryView(),
    const ScanView(),
    const HistoryView(),
    const ProfileView(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserState>(
      listener: (context, state) {
        // When user is loaded, trigger all user-dependent cubits to fetch data
        if (state is UserLoaded) {
          final profileCubit = context.read<ProfileCubit>();
          profileCubit.fetchProfileIfTokenAvailable(state.user.token);

          final commonDiseaseCubit = context.read<CommonDiseaseCubit>();
          commonDiseaseCubit.fetchCommonDiseasesIfUserAvailable();

          final historyCubit = context.read<HistoryCubit>();
          historyCubit.loadHistoryIfUserAvailable();
        }
      },
      child: SafeArea(
          child: Scaffold(
        body: pages[selectedIndex],
        bottomNavigationBar: CurvedNavigationBar(
          height: 55,
          index: selectedIndex,
          backgroundColor: kScaffoldColor,
          color: kMainColor,
          animationDuration: const Duration(milliseconds: 250),
          items: const [
            Icon(
              Icons.home,
              size: 30,
              color: Colors.white,
            ),
            Icon(
              Icons.library_books,
              size: 30,
              color: Colors.white,
            ),
            Icon(
              Icons.qr_code,
              size: 30,
              color: Colors.white,
            ),
            Icon(
              Icons.history,
              size: 30,
              color: Colors.white,
            ),
            Icon(
              Icons.person,
              size: 30,
              color: Colors.white,
            ),
          ],
          onTap: _onItemTapped,
        ),
      )),
    );
  }
}
