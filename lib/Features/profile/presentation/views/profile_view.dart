import 'package:flutter/material.dart';
import 'package:mazraaty/Features/profile/presentation/views/widgets/profile_view_body.dart';
import 'package:mazraaty/constants.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        backgroundColor: kScaffoldColor,
        body: ProfileViewBody(),
      ),
    );
  }
}
