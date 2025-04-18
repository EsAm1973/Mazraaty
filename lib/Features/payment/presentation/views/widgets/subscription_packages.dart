import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mazraaty/Core/utils/app_router.dart';
import 'package:mazraaty/Features/payment/data/models/package.dart';
import 'package:mazraaty/Features/payment/presentation/manager/Package%20Cubit/cubit/packages_cubit.dart';
import 'package:mazraaty/constants.dart';

class SubscriptionPackages extends StatefulWidget {
  final List<Package> packages;

  const SubscriptionPackages({super.key, required this.packages});

  @override
  State<SubscriptionPackages> createState() => _SubscriptionPackagesState();
}

class _SubscriptionPackagesState extends State<SubscriptionPackages> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Package list
        Expanded(
          child: ListView.builder(
            itemCount: widget.packages.length,
            itemBuilder: (context, index) {
              final package = widget.packages[index];
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.01, // 1% of screen height
                  ),
                  child: Card(
                    color: selectedIndex == index
                        ? Colors.green[100]
                        : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.05), // 5% of screen width
                      side: const BorderSide(color: Colors.green),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04), // 4% of screen width
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  package.name,
                                  style: GoogleFonts.poppins(
                                    color: kMainColor,
                                    fontSize: MediaQuery.of(context).size.width * 0.05, // 5% of screen width
                                    fontWeight: FontWeight.w800,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(width: MediaQuery.of(context).size.width * 0.03), // 3% of screen width
                              if (package.badge.isNotEmpty)
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: MediaQuery.of(context).size.width * 0.02, // 2% of screen width
                                    vertical: MediaQuery.of(context).size.height * 0.005, // 0.5% of screen height
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.05), // 5% of screen width
                                  ),
                                  child: Text(
                                    package.badge,
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: MediaQuery.of(context).size.width * 0.025, // 2.5% of screen width
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.015), // 1.5% of screen height
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text(
                                  package.description,
                                  style: GoogleFonts.poppins(
                                    color: Colors.grey,
                                    fontSize: MediaQuery.of(context).size.width * 0.035, // 3.5% of screen width
                                    fontWeight: FontWeight.w600,
                                  ),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(width: MediaQuery.of(context).size.width * 0.03), // 3% of screen width
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        "\$${package.price}",
                                        style: GoogleFonts.poppins(
                                          color: kMainColor,
                                          fontSize: MediaQuery.of(context).size.width * 0.065, // 6.5% of screen width
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: MediaQuery.of(context).size.height * 0.005), // 0.5% of screen height
                                    Text(
                                      "${package.coins} Coins",
                                      style: GoogleFonts.poppins(
                                        color: kMainColor,
                                        fontSize: MediaQuery.of(context).size.width * 0.03, // 3% of screen width
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.04), // 4% of screen height
        SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.07, // 7% of screen height
          child: ElevatedButton(
            onPressed: selectedIndex != null
                ? () {
                    final selectedPackage = widget.packages[selectedIndex!];
                    _navigateToPaymentMethods(context, selectedPackage);
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: kMainColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.04), // 4% of screen width
              ),
              padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.015, // 1.5% of screen height
                horizontal: MediaQuery.of(context).size.width * 0.08, // 8% of screen width
              ),
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                'Continue to purchase',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.width * 0.045, // 4.5% of screen width
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _navigateToPaymentMethods(BuildContext context, Package package) {
    final packagesCubit = context.read<PackagesCubit>();
    GoRouter.of(context).push(
      AppRouter.kPaymentMethodsView,
      extra: {
        'packageId': package.id,
        'packageName': package.name,
        'coins': package.coins,
        'price': package.price,
        'currency': packagesCubit.selectedCurrency,
      },
    );
  }
}
