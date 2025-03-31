import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mazraaty/constants.dart';

class SubscriptionPackages extends StatefulWidget {
  const SubscriptionPackages({super.key});

  @override
  State<SubscriptionPackages> createState() => _SubscriptionPackagesState();
}

class _SubscriptionPackagesState extends State<SubscriptionPackages> {
  int? selectedIndex;

  // البيانات هنا يمكن جلبها من API مستقبلاً
  final List<Map<String, dynamic>> packages = [
    {
      'title': 'Yearly',
      'subtitle': 'Save 50%\nGet 7 Days Free',
      'price': '60\$',
      'duration': 'yearly',
      'originalPrice': '120\$',
      'badge': 'BEST VALUE',
      'description': 'Subscription for one year',
    },
    {
      'title': '3 Month',
      'subtitle': 'Save 20%\nGet 3 Days Free',
      'price': '25\$',
      'duration': 'Quarter',
      'originalPrice': '30\$',
      'badge': 'MOST POPULAR',
      'description': 'Subscription for three months',
    },
    {
      'title': '1 Month',
      'subtitle': 'Save 16%',
      'price': '8.5\$',
      'duration': 'Monthly',
      'originalPrice': '10\$',
      'badge': '',
      'description': 'Subscription for one month',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // استخدام SizedBox لتحديد ارتفاع القائمة
        SizedBox(
          height:
              MediaQuery.of(context).size.height * 0.6, // تحديد ارتفاع مناسب
          child: ListView.builder(
            itemCount: packages.length,
            itemBuilder: (context, index) {
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
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(packages[index]['title'],
                                  style: GoogleFonts.poppins(
                                    color: kMainColor,
                                    fontSize: 26,
                                    fontWeight: FontWeight.w800,
                                  )),
                              const SizedBox(
                                width: 30,
                              ),
                              if (packages[index]['badge'] != '')
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(packages[index]['badge'],
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(packages[index]['subtitle'],
                                  style: GoogleFonts.poppins(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  )),
                              Column(
                                children: [
                                  Text(
                                    packages[index]['originalPrice'],
                                    style: GoogleFonts.poppins(
                                      color: kMainColor,
                                      fontSize: 16,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                  Text(
                                    packages[index]['price'],
                                    style: GoogleFonts.poppins(
                                      color: kMainColor,
                                      fontSize: 26,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    packages[index]['duration'],
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
                    // تنفيذ الانتقال مع البيانات المختارة
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
              'Continue to subscribe',
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
