import 'package:flutter/material.dart';
import 'package:mazraaty/Core/utils/styles.dart';
import 'package:mazraaty/Features/authentication/presentation/views/widgets/resetpass_title.dart';
import 'package:mazraaty/constants.dart';

class ResetPassViewBody extends StatelessWidget {
  const ResetPassViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ResetPassTitle(),
        ],
      ),
    );
  }
}

