import 'package:flutter/material.dart';
import 'package:mazraaty/Core/utils/styles.dart';
import 'package:mazraaty/Features/scan_plant/presentation/manager/Scan/scan_state.dart';
import 'package:mazraaty/constants.dart';

class BottomSheetWidget extends StatelessWidget {
  final ScanState state;

  const BottomSheetWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.max, // Changed to max
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              state.diseaseName,
              style: Styles.textStyle30
                  .copyWith(fontWeight: FontWeight.bold, color: kMainColor),
            ),
            const SizedBox(height: 8),
            Text(
              'Confidence: ${(state.confidence * 100).toStringAsFixed(1)}%',
              style: Styles.textStyle18.copyWith(color: Colors.black54),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: Scrollbar(
                thickness: 6,
                radius: const Radius.circular(2),
                thumbVisibility: true,
                interactive: true,
                controller: ScrollController(),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: Text(
                      'Mint Rust is a fungal disease that primarily affects plants in the Mint family (Lamiaceae), such as peppermint (Mentha piperita) and spearmint (Mentha spicata). The disease manifests as small, orange, yellow, or reddish pustules on the undersides of the leaves, which can eventually lead to leaf drop, reduced vigor, and plant death if left untreated.',
                      style: Styles.textStyle15.copyWith(color: Colors.black54),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10), // Replaced Spacer with SizedBox
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(12),
                  backgroundColor: kMainColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  foregroundColor: Colors.white,
                ),
                onPressed: () {},
                child: const Text(
                  'Read More',
                  style: Styles.textStyle20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
