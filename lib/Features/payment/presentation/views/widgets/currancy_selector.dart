import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mazraaty/Features/payment/presentation/manager/Package%20Cubit/cubit/packages_cubit.dart';
import 'package:mazraaty/constants.dart';

class CurrencySelector extends StatelessWidget {
  const CurrencySelector({super.key});

  @override
  Widget build(BuildContext context) {
    final packagesCubit = context.read<PackagesCubit>();
    return Row(
      children: [
        Text(
          'Select Currency:',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(color: kMainColor.withOpacity(0.5)),
              borderRadius: BorderRadius.circular(12),
              color: kMainColor.withOpacity(0.05),
            ),
            child: DropdownButtonHideUnderline(
              child: BlocBuilder<PackagesCubit, PackagesState>(
                builder: (context, state) {
                  return DropdownButton<String>(
                    value: packagesCubit.selectedCurrency,
                    icon:
                        const Icon(Icons.currency_exchange, color: kMainColor),
                    style: GoogleFonts.poppins(
                      color: kMainColor,
                      fontWeight: FontWeight.w600,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    isDense: true,
                    isExpanded: true,
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        packagesCubit.setCurrency(newValue);
                      }
                    },
                    items: <String>[
                      'USD',
                      'EUR',
                      'GBP',
                      'JPY',
                      'AUD',
                      'CAD',
                      'EGP',
                      'CHF',
                      'CNY',
                      'INR',
                      'BRL'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _getCurrencyIcon(value),
                            const SizedBox(width: 8),
                            Text(value),
                          ],
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _getCurrencyIcon(String currency) {
    IconData iconData;

    switch (currency) {
      case 'USD':
        iconData = Icons.attach_money;
        break;
      case 'EUR':
        iconData = Icons.euro;
        break;
      case 'GBP':
        iconData = Icons.currency_pound;
        break;
      case 'JPY':
        iconData = Icons.currency_yen;
        break;
      case 'AUD':
      case 'CAD':
        iconData = FontAwesomeIcons.dollarSign;
        break;
      case 'EGP':
        iconData = Icons.currency_pound; // Egyptian pound icon
        break;
      case 'CHF':
        iconData = Icons.money; // Swiss Franc
        break;
      case 'CNY':
        iconData = Icons.currency_yen; // Chinese Yuan
        break;
      case 'INR':
        iconData = Icons.currency_rupee; // Indian Rupee
        break;
      case 'BRL':
        iconData = Icons.attach_money; // Brazilian Real
        break;
      default:
        iconData = Icons.monetization_on;
    }

    return Icon(iconData, size: 18, color: kMainColor);
  }
}
