import 'package:flutter/material.dart';
import 'package:mazraaty/Features/scan_plant/presentation/manager/Scan/scan_state.dart';

class BottomSheetWidget extends StatelessWidget {
  final ScanState state;

  const BottomSheetWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            state.diseaseName,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
          ),
          const SizedBox(height: 8),
          Text(
            'Confidence: ${(state.confidence * 100).toStringAsFixed(1)}%',
            style: TextStyle(fontSize: 16, color: Colors.grey[700]),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/diseaseDetails'),
            child: const Text('Read More'),
          ),
        ],
      ),
    );
  }
}
