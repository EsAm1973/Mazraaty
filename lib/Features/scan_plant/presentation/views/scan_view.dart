import 'package:flutter/material.dart';
import 'package:mazraaty/Features/scan_plant/presentation/views/widgets/scan_view_body.dart';

class ScanView extends StatelessWidget {
  const ScanView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
    //  backgroundColor: kScaffoldColor,
      appBar: AppBar(
      //  backgroundColor: kScaffoldColor,
        centerTitle: true,
        title: const Text('Scan Plant'),
      ),
      body: const ScanViewBody(),
    ));
  }
}
