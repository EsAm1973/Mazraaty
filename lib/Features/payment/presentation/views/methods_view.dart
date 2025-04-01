import 'package:flutter/material.dart';
import 'package:mazraaty/Features/payment/presentation/views/widgets/methods_view_body.dart';

class PaymentMethodsView extends StatelessWidget {
  const PaymentMethodsView({
    super.key,
    required this.packageId,
    required this.packageName,
    required this.coins,
    required this.price,
  });

  final int packageId;
  final String packageName;
  final int coins;
  final String price;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PaymentMethodsViewBody(
          packageId: packageId,
          packageName: packageName,
          coins: coins,
          price: price,
        ),
      ),
    );
  }
}
