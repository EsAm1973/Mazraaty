import 'package:flutter/material.dart';
import 'package:mazraaty/Features/authentication/presentation/views/widgets/signup_view_body.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        body: SignupViewBody(),
      ),
    );
  }
}
