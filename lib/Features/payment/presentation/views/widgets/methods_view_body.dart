import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mazraaty/Core/widgets/dialog_helper.dart';
import 'package:mazraaty/Features/payment/presentation/manager/Payment%20Cubit/payment_cubit.dart';
import 'package:mazraaty/Features/payment/presentation/views/widgets/backbutton_methods.dart';
import 'package:mazraaty/Features/payment/presentation/views/widgets/custom_dialog.dart';
import 'package:mazraaty/Features/payment/presentation/views/widgets/methods_listview.dart';
import 'package:mazraaty/Features/payment/presentation/views/widgets/pay_button.dart';
import 'package:mazraaty/Features/payment/presentation/views/widgets/title_methods.dart';

class PaymentMethodsViewBody extends StatefulWidget {
  final int packageId;
  final String packageName;
  final int coins;
  final String price;

  const PaymentMethodsViewBody({
    super.key,
    required this.packageId,
    required this.packageName,
    required this.coins,
    required this.price,
  });

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
    return BlocListener<PaymentCubit, PaymentState>(
      listener: (context, state) {
        if (state is PaymentLoading) {
          DialogHelper.showLoading(context);
        } else if (state is PaymentFailure) {
          // Hide loading dialog if showing
          DialogHelper.hideLoading();

          // Show error dialog
          DialogHelper.showError(
            context,
            'Payment Error',
            state.errorMessage,
          );
        } else if (state is PaymentSuccess) {
          // Hide loading dialog if showing
          DialogHelper.hideLoading();

          // If payment wasn't successful, show error
          if (!state.paymentResponse.success) {
            DialogHelper.showError(
              context,
              'Payment Failed',
              'There was a problem processing your payment. Please try again.',
            );
          } else {
            // Could optionally show a success message before redirection
            // Note: The URL will be launched automatically by the cubit
          }
        }
      },
      child: Padding(
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
            Align(
              alignment: Alignment.center,
              child: Text(
                'Select your payment method for ${widget.packageName} - \$${widget.price}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
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
            const SizedBox(height: 40),
            PayNowButton(
              onPressed: () {
                if (_selectedPaymentMethod == 'paypal') {
                  context.read<PaymentCubit>().initiatePaypalPayment(
                        packageId: widget.packageId,
                      );
                } else {
                  // Handle other payment methods
                  showDialog(
                    context: context,
                    builder: (context) => CustomDialog(
                      title: 'Not Implemented',
                      content: 'This payment method is not yet implemented.',
                      buttonText: 'OK',
                      onPressed: () => Navigator.pop(context),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
