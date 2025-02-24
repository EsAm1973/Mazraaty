import 'package:flutter/material.dart';
import 'package:mazraaty/Core/widgets/custom_listtile.dart';

class ProfilePolicesListTile extends StatelessWidget {
  const ProfilePolicesListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      leadingIcon: Icons.balance_outlined,
      title: 'Our Polices',
      trailingIcon: const Icon(Icons.arrow_forward_ios, size: 20),
      onTap: () {},
    );
  }
}
