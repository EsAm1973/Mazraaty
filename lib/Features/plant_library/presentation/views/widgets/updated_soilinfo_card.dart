import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UpdatedDetailsSoilInfoCard extends StatelessWidget {
  final String soilType;
  final String drainage;
  final double minPH;
  final double maxPH;

  const UpdatedDetailsSoilInfoCard({
    super.key,
    required this.soilType,
    required this.drainage,
    required this.minPH,
    required this.maxPH,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(
                'assets/images/maintance.png',
                width: 30,
                height: 30,
              ),
              const SizedBox(width: 8),
              Text(
                "Soil",
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // معلومات التربة
          RichText(
            text: TextSpan(
              style: GoogleFonts.montserrat(
                fontSize: 16,
                color: Colors.black,
                height: 1.7, // التحكم في المسافة بين الأسطر
              ),
              children: [
                TextSpan(
                  text: "Type: ",
                  style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: soilType),
                const TextSpan(
                  text: "\n",
                ),
                TextSpan(
                  text: "Drainage: ",
                  style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: drainage),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // شريط نطاق pH مع الصندوق والسهم والمسافة المطلوبة
          Stack(
            clipBehavior: Clip.none,
            children: [
              _buildPHScale(context), // شريط pH متجاوب
              _buildPHIndicator(context), // المؤشر المتحرك مع الصندوق
            ],
          ),
        ],
      ),
    );
  }

  // 🔹 شريط pH مع عرض متجاوب
  Widget _buildPHScale(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double availableWidth = screenWidth - 64; // العرض المتاح بعد الهوامش
    double boxWidth =
        (availableWidth - (4 * 13)) / 14; // تصغير العرض لاستيعاب المسافات

    List<Color> phColors = [
      Colors.red.shade300,
      Colors.orange.shade300,
      Colors.yellow.shade300,
      Colors.yellow.shade400,
      Colors.green.shade300,
      Colors.green.shade500,
      Colors.green.shade700,
      Colors.green.shade800,
      Colors.blue.shade300,
      Colors.blue.shade400,
      Colors.blue.shade500,
      Colors.purple.shade300,
      Colors.purple.shade400,
      Colors.purple.shade500,
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center, // وسط العناصر
      children: List.generate(14, (index) {
        bool isInRange = index + 1 >= minPH && index + 1 <= maxPH;
        return Row(
          children: [
            Container(
              width: boxWidth, // العرض المتجاوب
              height: 50,
              decoration: BoxDecoration(
                color: phColors[index],
                borderRadius: BorderRadius.circular(6), // حواف مستديرة
              ),
              child: Center(
                child: Text("${index + 1}",
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: isInRange ? Colors.white : Colors.black,
                    )),
              ),
            ),
            if (index < 13) const SizedBox(width: 4), // مسافة بين العناصر
          ],
        );
      }),
    );
  }

  // 🔹 الصندوق والسهم مع وجود مسافة كافية بينهما وبين الشريط
  Widget _buildPHIndicator(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double availableWidth = screenWidth - 64; // العرض بعد الهوامش
    double boxWidth =
        (availableWidth - (4 * 13)) / 14; // تصغير العرض لاستيعاب المسافات

    // حساب موضع المؤشر بالنسبة للشريط
    double startPosition = ((minPH - 1) / 14) * availableWidth;
    double endPosition = ((maxPH - 1) / 14) * availableWidth;
    double boxPosition = (startPosition + endPosition) / 2; // وسط النطاق

    // حساب الفهرس الذي يقع عليه المؤشر للحصول على اللون المناسب
    int indicatorIndex =
        ((boxPosition / availableWidth) * 14).round().clamp(0, 13);
    List<Color> phColors = [
      Colors.red.shade300,
      Colors.orange.shade300,
      Colors.yellow.shade300,
      Colors.yellow.shade400,
      Colors.green.shade300,
      Colors.green.shade500,
      Colors.green.shade700,
      Colors.green.shade800,
      Colors.blue.shade300,
      Colors.blue.shade400,
      Colors.blue.shade500,
      Colors.purple.shade300,
      Colors.purple.shade400,
      Colors.purple.shade500,
    ];

    Color indicatorColor =
        phColors[indicatorIndex]; // لون المؤشر والصندوق بناءً على موضعه

    return Positioned(
      left: boxPosition - 30, // ضبط الموقع بناءً على القيم
      bottom: -60, // مسافة بين المؤشر والشريط
      child: Column(
        children: [
          Icon(
            Icons.arrow_drop_down,
            color: indicatorColor, // تغيير لون السهم إلى اللون المطابق
            size: 30,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            decoration: BoxDecoration(
              color: indicatorColor, // تغيير لون الصندوق إلى اللون المطابق
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text("${minPH.toDouble()} pH - ${maxPH.toDouble()} pH",
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                )),
          ),
        ],
      ),
    );
  }
}
