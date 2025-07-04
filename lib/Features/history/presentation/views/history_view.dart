import 'package:flutter/material.dart';
import 'package:mazraaty/Features/history/presentation/views/widgets/history_view_body.dart';
import 'package:mazraaty/constants.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: Scaffold(
      backgroundColor: kScaffoldColor,
      body: HistoryViewBody(),
    ));
  }
}
