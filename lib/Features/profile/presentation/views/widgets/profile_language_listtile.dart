import 'package:flutter/material.dart';
import 'package:mazraaty/Core/widgets/custom_listtile.dart';

class ProfileLanguageListTile extends StatelessWidget {
  const ProfileLanguageListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      leadingIcon: Icons.translate,
      title: 'Language',
      trailingIcon: const Icon(Icons.arrow_forward_ios, size: 20),
      onTap: () {},
    );
  }
}
