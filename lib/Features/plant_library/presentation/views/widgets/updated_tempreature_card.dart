import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UpdatedDetailsTemperature extends StatelessWidget {
  final double minTemp;
  final double idealMin;
  final double idealMax;
  final double maxTemp;

  const UpdatedDetailsTemperature({
    super.key,
    required this.minTemp,
    required this.idealMin,
    required this.idealMax,
    required this.maxTemp,
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
                'assets/images/temperature.png',
                width: 30,
                height: 30,
              ),
              const SizedBox(width: 8),
              Text(
                "Temperature needs",
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _buildTemperatureScale(),
          const SizedBox(height: 8),
          _buildLegend(),
          const SizedBox(height: 18),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/images/idea.png', width: 30, height: 30),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  "Just like people, each plant has its own preferences. Learn about your plants’ Temperature needs and create a comforting environment for them to flourish.",
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTemperatureScale() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("${minTemp.toInt()} C"),
            Text("${idealMin.toInt()}"),
            Text("${idealMax.toInt()}"),
            Text("${maxTemp.toInt()}"),
          ],
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            height: 17,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.shade300, // الخلفية الافتراضية للشريط
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                // ❌ Unsuitable (قبل Tolerable)
                Flexible(
                  flex: ((idealMin - minTemp) * 100 ~/ (maxTemp - minTemp)),
                  child: Container(
                    height: 17,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400, // ❌ Unsuitable
                      borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(8),
                      ),
                    ),
                  ),
                ),

                // 🔵 Tolerable (قبل Ideal)
                Flexible(
                  flex: ((idealMin - minTemp) * 50 ~/ (maxTemp - minTemp)),
                  child: Container(
                    height: 17,
                    color: Colors.blue.shade300, // 🔵 Tolerable
                  ),
                ),

                // ✅ Ideal (المنطقة المثالية)
                Flexible(
                  flex: ((idealMax - idealMin) * 100 ~/ (maxTemp - minTemp)),
                  child: Container(
                    height: 17,
                    color: Colors.green.shade700, // ✅ Ideal
                  ),
                ),

                // 🔵 Tolerable (بعد Ideal)
                Flexible(
                  flex: ((maxTemp - idealMax) * 50 ~/ (maxTemp - minTemp)),
                  child: Container(
                    height: 17,
                    color: Colors.blue.shade300, // 🔵 Tolerable
                  ),
                ),

                // ❌ Unsuitable (بعد Tolerable)
                Flexible(
                  flex: ((maxTemp - idealMax) * 100 ~/ (maxTemp - minTemp)),
                  child: Container(
                    height: 17,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400, // ❌ Unsuitable
                      borderRadius: const BorderRadius.horizontal(
                        right: Radius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _legendItem("Ideal", Colors.green.shade700),
        _legendItem("Tolerable", Colors.blue.shade300),
        _legendItem("Unsuitable", Colors.grey.shade400),
      ],
    );
  }

  Widget _legendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(label, style: GoogleFonts.montserrat(fontSize: 14)),
      ],
    );
  }
}
