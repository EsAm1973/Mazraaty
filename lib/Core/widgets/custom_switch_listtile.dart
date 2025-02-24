import 'package:flutter/material.dart';
import 'package:mazraaty/constants.dart';

class CustomSwitchTile extends StatefulWidget {
  final IconData leadingIcon;
  final String title;
  final bool initialValue;
  final ValueChanged<bool>? onChanged;

  const CustomSwitchTile({
    super.key,
    required this.leadingIcon,
    required this.title,
    this.initialValue = false,
    this.onChanged,
  });

  @override
  _CustomSwitchTileState createState() => _CustomSwitchTileState();
}

class _CustomSwitchTileState extends State<CustomSwitchTile> {
  late bool _switchValue;

  @override
  void initState() {
    super.initState();
    _switchValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(widget.leadingIcon, color: Colors.black),
      title: Text(widget.title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
      trailing: Switch(
        activeColor: kMainColor,
        value: _switchValue,
        onChanged: (value) {
          setState(() {
            _switchValue = value;
          });
          if (widget.onChanged != null) {
            widget.onChanged!(value);
          }
        },
      ),
    );
  }
}
