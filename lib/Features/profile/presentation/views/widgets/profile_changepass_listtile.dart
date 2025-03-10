import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mazraaty/Core/utils/app_router.dart';
import 'package:mazraaty/Core/widgets/custom_listtile.dart';

class ProfileChangePassword extends StatelessWidget {
  const ProfileChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      leadingIcon: Icons.lock_open_outlined,
      title: 'Change Password',
      trailingIcon: const Icon(Icons.arrow_forward_ios, size: 20),
      onTap: () {
        GoRouter.of(context).push(AppRouter.kRecoverPassView);
      },
    );
  }
}
