import 'package:flutter/material.dart';
import 'package:mazraaty/Core/utils/styles.dart';
import 'package:mazraaty/Features/history/presentation/views/widgets/history_listview.dart';
import 'package:mazraaty/constants.dart';

class HistoryViewBody extends StatelessWidget {
  const HistoryViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 20),
      child: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              'History',
              style: Styles.textStyle38.copyWith(
                fontFamily: kfontFamily,
                color: kMainColor,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const HistoryListView(),
        ],
      ),
    );
  }
}
