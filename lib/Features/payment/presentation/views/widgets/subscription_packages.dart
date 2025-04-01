import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mazraaty/Core/utils/app_router.dart';
import 'package:mazraaty/Features/payment/data/models/package.dart';
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
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Card(
                    color: selectedIndex == index
                        ? Colors.green[100]
                        : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      side: const BorderSide(color: Colors.green),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(package.name,
                                  style: GoogleFonts.poppins(
                                    color: kMainColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                  )),
                              const SizedBox(width: 30),
                              if (package.badge.isNotEmpty)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(package.badge,
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(package.description,
                                    style: GoogleFonts.poppins(
                                      color: Colors.grey,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    )),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Column(
                                children: [
                                  Text(
                                    "\$${package.price}",
                                    style: GoogleFonts.poppins(
                                      color: kMainColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "${package.coins} Coins",
                                    style: GoogleFonts.poppins(
                                      color: kMainColor,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
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
        const SizedBox(height: 30),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: selectedIndex != null
                ? () {
                    final selectedPackage = widget.packages[selectedIndex!];
                    GoRouter.of(context).push(
                      AppRouter.kPaymentMethodsView,
                      extra: {
                        'packageId': selectedPackage.id,
                        'packageName': selectedPackage.name,
                        'coins': selectedPackage.coins,
                        'price': selectedPackage.price,
                      },
                    );
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: kMainColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 40),
            ),
            child: Text(
              'Continue to purchase',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
