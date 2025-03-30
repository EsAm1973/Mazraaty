import 'package:flutter/material.dart';
import 'package:mazraaty/Features/payment/presentation/views/widgets/packages_view_body.dart';

class PackagesView extends StatelessWidget {
  const PackagesView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: Scaffold(
      body: PackagesViewBody(),
    ));
  }
}
