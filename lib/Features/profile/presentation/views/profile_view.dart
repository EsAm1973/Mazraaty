import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mazraaty/Features/profile/presentation/views/widgets/profile_view_body.dart';
import 'package:mazraaty/constants.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
        automaticallyImplyLeading: false,
        toolbarHeight: 0,
      ),
      body: const SafeArea(
        child: ProfileViewBody(),
      ),
    );
  }
}
