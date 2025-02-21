import 'package:flutter/material.dart';
import 'package:mazraaty/Features/authentication/presentation/views/widgets/resetpass_view_body.dart';

class ResetPassView extends StatelessWidget {
  const ResetPassView({super.key});

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
        child: Scaffold(
      body: ResetPassViewBody(),
    ));
  }
}
