import 'package:flutter/material.dart';
import 'package:mazraaty/Core/utils/styles.dart';

class CustomListTileForDeleteAndLogOut extends StatelessWidget {
  const CustomListTileForDeleteAndLogOut({
    super.key,
    required this.leadingIcon,
    required this.title,
    required this.trailingIcon,
    this.onTap,
  });
  final IconData leadingIcon;
  final String title;
  final Widget trailingIcon;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        leadingIcon,
        color: Colors.red,
        size: 26,
      ),
      title: Text(
        title,
        style: Styles.textStyle16.copyWith(color: Colors.red),
      ),
      trailing: trailingIcon,
      onTap: onTap,
    );
  }
}
