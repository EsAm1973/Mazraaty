import 'package:flutter/material.dart';
import 'package:mazraaty/Core/utils/styles.dart';

class UpdatedDetailsPlantDetails extends StatelessWidget {
  const UpdatedDetailsPlantDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildRichText("Botanical Name: ", "Mentha-Mint"),
        const SizedBox(height: 8),
        _buildRichText("Scientific Name: ", "Mentha-Mint"),
        const SizedBox(height: 12),
        _buildRichText(
          "Also known as: ",
          '"Spearmint", "Peppermint".',
          isItalic: false,
          isBold: true,
        ),
      ],
    );
  }

  Widget _buildRichText(String label, String value,
      {bool isItalic = true, bool isBold = false}) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: label,
            style: Styles.textStyle18
                .copyWith(color: Colors.black87, fontWeight: FontWeight.w500),
          ),
          TextSpan(
              text: value,
              style: Styles.textStyle18.copyWith(
                color: Colors.black,
                fontWeight: isBold ? FontWeight.bold : FontWeight.bold,
                fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
              )),
        ],
      ),
    );
  }
}
