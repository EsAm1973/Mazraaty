import 'package:flutter/material.dart';
import 'package:mazraaty/Features/payment/presentation/views/widgets/methods_view_body.dart';

class PaymentMethodsView extends StatelessWidget {
  const PaymentMethodsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: Scaffold(
      body: PaymentMethodsViewBody(),
    ));
  }
}
