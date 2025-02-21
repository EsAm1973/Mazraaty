import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mazraaty/Features/authentication/presentation/views/widgets/verifycode_backbutton.dart';
import 'package:mazraaty/Features/authentication/presentation/views/widgets/verifycode_title.dart';
import 'package:mazraaty/constants.dart';

class VerifyCodeViewBody extends StatelessWidget {
  const VerifyCodeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          VerifyCodeBackButton(onPressed: () {
            GoRouter.of(context).pop();
          }),
          const SizedBox(
            height: 110,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(children: [
              VerifyCodeTitle(),
            ]),
          ),
        ],
      ),
    );
  }
}