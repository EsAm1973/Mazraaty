import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mazraaty/Features/payment/presentation/views/widgets/back_button_packages_view.dart';
import 'package:mazraaty/Features/payment/presentation/views/widgets/title_packages_view.dart';

class PackagesViewBody extends StatelessWidget {
  const PackagesViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 27, vertical: 37),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BackButtonPackageView(onPressed: () => GoRouter.of(context).pop()),
          const SizedBox(
            height: 15,
          ),
          const TitlePackageViews(),
        ],
      ),
    );
  }
}