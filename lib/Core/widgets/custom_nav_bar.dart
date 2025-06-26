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
  late PageController _pageController;

  final List<Widget> pages = [
    const KeepAliveHomeView(),
    const KeepAliveLibraryView(),
    const KeepAliveScanView(),
    //const KeepAliveHistoryView(),
    const HistoryView(),
    const KeepAliveProfileView(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (index == selectedIndex) return;
    setState(() => selectedIndex = index);
    _pageController.jumpToPage(index);  // ← instant switch, no intermediate pages
  }

  void _onPageChanged(int index) {
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
        body: PageView(
          controller: _pageController,
          onPageChanged: _onPageChanged,
          physics: const NeverScrollableScrollPhysics(),
          children: pages,
        ),
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

// KeepAlive wrapper classes to maintain screen state
class KeepAliveHomeView extends StatefulWidget {
  const KeepAliveHomeView({super.key});

  @override
  State<KeepAliveHomeView> createState() => _KeepAliveHomeViewState();
}

class _KeepAliveHomeViewState extends State<KeepAliveHomeView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for AutomaticKeepAliveClientMixin
    return const HomeView();
  }
}

class KeepAliveLibraryView extends StatefulWidget {
  const KeepAliveLibraryView({super.key});

  @override
  State<KeepAliveLibraryView> createState() => _KeepAliveLibraryViewState();
}

class _KeepAliveLibraryViewState extends State<KeepAliveLibraryView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for AutomaticKeepAliveClientMixin
    return const LibraryView();
  }
}

class KeepAliveScanView extends StatefulWidget {
  const KeepAliveScanView({super.key});

  @override
  State<KeepAliveScanView> createState() => _KeepAliveScanViewState();
}

class _KeepAliveScanViewState extends State<KeepAliveScanView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for AutomaticKeepAliveClientMixin
    return const ScanView();
  }
}

class KeepAliveHistoryView extends StatefulWidget {
  const KeepAliveHistoryView({super.key});

  @override
  State<KeepAliveHistoryView> createState() => _KeepAliveHistoryViewState();
}

class _KeepAliveHistoryViewState extends State<KeepAliveHistoryView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for AutomaticKeepAliveClientMixin
    return const HistoryView();
  }
}

class KeepAliveProfileView extends StatefulWidget {
  const KeepAliveProfileView({super.key});

  @override
  State<KeepAliveProfileView> createState() => _KeepAliveProfileViewState();
}

class _KeepAliveProfileViewState extends State<KeepAliveProfileView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for AutomaticKeepAliveClientMixin
    return const ProfileView();
  }
}
