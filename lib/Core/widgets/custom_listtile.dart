import 'package:flutter/material.dart';
import 'package:mazraaty/Core/utils/styles.dart';

class CustomListTile extends StatelessWidget {
  final IconData leadingIcon;
  final String title;
  final Widget trailingIcon;
  final VoidCallback? onTap;

  const CustomListTile({
    super.key,
    required this.leadingIcon,
    required this.title,
    required this.trailingIcon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(leadingIcon, color: Colors.black),
      title: Text(
        title,
        style: Styles.textStyle16,
      ),
      trailing: trailingIcon,
      onTap: onTap,
    );
  }
}
