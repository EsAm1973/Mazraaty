import 'package:flutter/material.dart';
import 'package:mazraaty/Features/authentication/presentation/views/widgets/verify_code_view_body.dart';

class VerifyCodeView extends StatelessWidget {
  const VerifyCodeView({super.key, required this.email});
  final String email;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: VerifyCodeViewBody(
        email: email,
      ),
    ));
  }
}
