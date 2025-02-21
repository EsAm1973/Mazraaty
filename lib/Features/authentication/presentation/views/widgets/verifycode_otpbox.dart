import 'package:flutter/material.dart';

class VerifyCodeOtpBox extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode? nextFocusNode;
  final bool isLast;
  final void Function(String)? onChanged;

  const VerifyCodeOtpBox({
    super.key,
    required this.controller,
    required this.focusNode,
    this.nextFocusNode,
    this.isLast = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 60,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: InputDecoration(
          counterText: "",
          contentPadding: const EdgeInsets.all(0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onChanged: (value) {
          // Trigger the parent-supplied onChanged
          if (onChanged != null) {
            onChanged!(value);
          }

          // If user typed one character and it's not the last box, move focus
          if (value.length == 1 && !isLast) {
            FocusScope.of(context).requestFocus(nextFocusNode);
          }

          // If user clears a field, move focus back to the previous box
          if (value.isEmpty && focusNode.canRequestFocus) {
            FocusScope.of(context).previousFocus();
          }
        },
      ),
    );
  }
}
