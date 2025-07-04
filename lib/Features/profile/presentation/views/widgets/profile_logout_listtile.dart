import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mazraaty/Core/data/Cubits/User%20Cubit/user_cubit.dart';
import 'package:mazraaty/Core/utils/app_router.dart';
import 'package:mazraaty/Core/widgets/custom_listtile_delete_and_logout.dart';

class ProfileLogoutListTile extends StatelessWidget {
  const ProfileLogoutListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomListTileForDeleteAndLogOut(
      leadingIcon: Icons.logout,
      title: 'Logout',
      trailingIcon: const Icon(Icons.arrow_forward_ios, size: 20),
      onTap: () async {
        await context.read<UserCubit>().logout();
        GoRouter.of(context).pushReplacement(AppRouter.kLoginView);
      },
    );
  }
}
