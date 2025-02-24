import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mazraaty/Core/widgets/custom_listtile.dart';

class ProfileListTile extends StatelessWidget {
  const ProfileListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomListTile(
      leadingIcon: FontAwesomeIcons.user,
      title: 'Profile',
      trailingIcon: Icon(
        Icons.arrow_forward_ios,
        size: 20,
      ),
    );
  }
}
