import 'package:flutter/material.dart';
import 'package:mazraaty/Core/widgets/custom_switch_listtile.dart';

class ProfileDarkModeListTile extends StatelessWidget {
  const ProfileDarkModeListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomSwitchTile(
      leadingIcon: Icons.dark_mode_outlined,
      title: 'Dark Mode',
    );
  }
}
