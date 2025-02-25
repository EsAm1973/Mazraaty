import 'package:flutter/material.dart';
import 'package:mazraaty/Core/utils/styles.dart';
import 'package:mazraaty/Features/scan_plant/presentation/views/widgets/scan_view_body.dart';
import 'package:mazraaty/constants.dart';

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
        title: Text(
          'Scan Plant',
          style: Styles.textStyle26
              .copyWith(fontFamily: kfontFamily, color: kMainColor),
        ),
      ),
      body: const ScanViewBody(),
    ));
  }
}
