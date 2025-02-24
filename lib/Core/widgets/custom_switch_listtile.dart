import 'package:flutter/material.dart';

class CustomSwitchTile extends StatefulWidget {
  final IconData leadingIcon;
  final String title;
  final bool initialValue;
  final ValueChanged<bool>? onChanged;

  const CustomSwitchTile({
    Key? key,
    required this.leadingIcon,
    required this.title,
    this.initialValue = false,
    this.onChanged,
  }) : super(key: key);

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
      title: Text(widget.title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
      trailing: Switch(
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
