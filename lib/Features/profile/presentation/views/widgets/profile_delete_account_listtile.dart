import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:mazraaty/Core/utils/app_router.dart';
import 'package:mazraaty/Core/widgets/custom_listtile_delete_and_logout.dart';

class ProfileDeleteAccountListTile extends StatelessWidget {
  const ProfileDeleteAccountListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomListTileForDeleteAndLogOut(
      leadingIcon: FontAwesomeIcons.trashCan,
      title: 'Delete Account',
      trailingIcon: const Icon(Icons.arrow_forward_ios, size: 20),
      onTap: () {
        GoRouter.of(context).push(AppRouter.kDeleteAccountView);
      },
    );
  }
}
