import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mazraaty/Features/payment/presentation/views/widgets/backbutton_methods.dart';
import 'package:mazraaty/Features/payment/presentation/views/widgets/methods_listview.dart';
import 'package:mazraaty/Features/payment/presentation/views/widgets/title_methods.dart';

class PaymentMethodsViewBody extends StatefulWidget {
  const PaymentMethodsViewBody({super.key});

  @override
  State<PaymentMethodsViewBody> createState() => _PaymentMethodsViewBodyState();
}

class _PaymentMethodsViewBodyState extends State<PaymentMethodsViewBody> {
  String _selectedPaymentMethod = 'paypal'; // Default selected payment method
  final List<Map<String, dynamic>> _paymentMethods = [
    {
      'id': 'credit_card',
      'name': 'Credit Card',
      'icon': 'assets/images/visa.png',
    },
    {
      'id': 'paypal',
      'name': 'Paypal',
      'icon': 'assets/images/paypal.png',
    },
    {
      'id': 'apple_pay',
      'name': 'Apple pay',
      'icon': 'assets/images/apple.png',
    },
    {
      'id': 'google_pay',
      'name': 'Google pay',
      'icon': 'assets/images/google.png',
    },
  ];

  void _onPaymentMethodSelected(String paymentMethodId) {
    setState(() {
      _selectedPaymentMethod = paymentMethodId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 27, vertical: 37),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BackButtonMethodsView(onPressed: () => GoRouter.of(context).pop()),
          const SizedBox(
            height: 15,
          ),
          const TitlePaymentMethods(),
          const SizedBox(
            height: 15,
          ),
          const Align(
            alignment: Alignment.center,
            child: Text(
              'Select your payment method',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(
            height: 33,
          ),
          PaymentMethodsListView(
            paymentMethods: _paymentMethods,
            selectedPaymentMethod: _selectedPaymentMethod,
            onPaymentMethodSelected: _onPaymentMethodSelected,
          ),
        ],
      ),
    );
  }
}
