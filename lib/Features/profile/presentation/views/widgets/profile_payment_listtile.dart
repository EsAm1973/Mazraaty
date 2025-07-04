import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mazraaty/Core/utils/app_router.dart';
import 'package:mazraaty/Core/widgets/custom_listtile.dart';

class ProfilePaymentListTile extends StatelessWidget {
  const ProfilePaymentListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      leadingIcon: Icons.payment_outlined,
      title: 'Buy Now',
      trailingIcon: const Icon(
        Icons.arrow_forward_ios,
        size: 20,
      ),
      onTap: () {
        GoRouter.of(context).push(AppRouter.kPaymentPackgesView);
      },
    );
  }
}
