import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentMethodTile extends StatelessWidget {
  final String icon;
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const PaymentMethodTile({
    super.key,
    required this.icon,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Image.asset(
              icon,
              width: 30,
              height: 30,
            ),
            const SizedBox(width: 16),
            Text(title,
                style: GoogleFonts.poppins(
                    fontSize: 18, fontWeight: FontWeight.w500)),
            const Spacer(),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color:
                      isSelected ? Colors.green : Colors.grey.withOpacity(0.5),
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Container(
                      margin: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green,
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
