import 'package:flutter/material.dart';
import 'package:mazraaty/Features/authentication/presentation/views/widgets/resetpass_view_body.dart';

class ResetPassView extends StatelessWidget {
  const ResetPassView({super.key, required this.email, required this.token});
  final String email;
  final String token;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: ResetPassViewBody(
        email: email,
        token: token,
      ),
    ));
  }
}
