import 'package:flutter/material.dart';
import 'package:mazraaty/Features/history/presentation/views/widgets/history_list_item.dart';

class HistoryListView extends StatelessWidget {
  const HistoryListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: 10,
        itemBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 3),
            child: HistoryListItem(),
          );
        },
      ),
    );
  }
}
