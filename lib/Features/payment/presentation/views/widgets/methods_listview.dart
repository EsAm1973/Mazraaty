import 'package:flutter/material.dart';
import 'package:mazraaty/Features/payment/presentation/views/widgets/payment_method_tile.dart';

class PaymentMethodsListView extends StatelessWidget {
  final List<Map<String, dynamic>> paymentMethods;
  final String selectedPaymentMethod;
  final Function(String) onPaymentMethodSelected;

  const PaymentMethodsListView({
    super.key,
    required this.paymentMethods,
    required this.selectedPaymentMethod,
    required this.onPaymentMethodSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: paymentMethods.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final method = paymentMethods[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: PaymentMethodTile(
            icon: method['icon'],
            title: method['name'],
            isSelected: selectedPaymentMethod == method['id'],
            onTap: () {
              onPaymentMethodSelected(method['id']);
            },
          ),
        );
      },
    );
  }
}
