import 'package:flutter/material.dart';
import 'package:mazraaty/Features/authentication/presentation/views/widgets/recoverpass_view_body.dart';

class RecoverPassView extends StatelessWidget {
  const RecoverPassView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: RecoverPassViewBody(),
    ));
  }
}
