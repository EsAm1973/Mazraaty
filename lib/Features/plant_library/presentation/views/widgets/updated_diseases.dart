
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UpdatedDetailsDiseases extends StatelessWidget {
  const UpdatedDetailsDiseases(
      {super.key, required this.pests, required this.diseases});
  final String pests;
  final String diseases;
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
                'assets/images/bug.png', // أيقونة الحشرات
                width: 24,
                height: 24,
              ),
              const SizedBox(width: 8),
              Text(
                "Pests & Diseases",
                style: GoogleFonts.montserrat(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildCategoryColumn(
                "Pests",
                // هنا بنفصل النص عند كل فاصلة ونشيل الفراغات الزائدة
                pests.split(',').map((e) => e.trim()).toList(),
                Colors.red.shade400,
              ),
              const SizedBox(width: 16),
              _buildDynamicDivider(),
              const SizedBox(width: 16),
              _buildCategoryColumn(
                "Diseases",
                // هنا بفصل الـ String عند الفواصل وبشيل الفراغات الزايدة
                diseases.split(',').map((e) => e.trim()).toList(),
                Colors.pink.shade400,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryColumn(String title, List<String> items, Color color) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.montserrat(
              fontSize: 16,
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          ...items.map(
            (item) => Text(
              "- $item",
              style: GoogleFonts.montserrat(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDynamicDivider() {
    // نفصل النص عند الفواصل وننظف الفراغات
    final pestsCount =
        pests.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).length;
    final diseasesCount = diseases
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .length;

    // أكبر عدد من العناصر
    final maxCount = pestsCount > diseasesCount ? pestsCount : diseasesCount;

    // نفترض لكل عنصر ارتفاع ~20 بكسل (تقدر تعدله)
    final dividerHeight = maxCount * 40.0;

    return Container(
      width: 2,
      height: dividerHeight,
      color: Colors.black54,
    );
  }
}
