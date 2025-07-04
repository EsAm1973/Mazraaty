import 'package:flutter/material.dart';
import 'package:mazraaty/Features/history/presentation/views/widgets/history_list_item.dart';

class HistoryListView extends StatelessWidget {
  const HistoryListView({super.key, required this.diseases});
  final List<dynamic> diseases;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: diseases.length,
      itemBuilder: (context, index) {
        final disease = diseases[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: HistoryListItem(
            disease: disease,
          ),
        );
      },
    );
  }
}
