import 'package:flutter/material.dart';
import 'package:mazraaty/Core/widgets/custom_listtile_delete_and_logout.dart';

class ProfileLogoutListTile extends StatelessWidget {
  const ProfileLogoutListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomListTileForDeleteAndLogOut(
      leadingIcon: Icons.logout,
      title: 'Logout',
      trailingIcon: const Icon(Icons.arrow_forward_ios, size: 20),
      onTap: () {},
    );
  }
}
