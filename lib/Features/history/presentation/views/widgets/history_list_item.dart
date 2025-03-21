import 'package:flutter/material.dart';
import 'package:mazraaty/Core/utils/styles.dart';
import 'package:mazraaty/Features/history/data/models/history_model.dart';
import 'package:mazraaty/constants.dart';

class HistoryListItem extends StatelessWidget {
  const HistoryListItem({super.key, required this.disease});
  final HistoryDisease disease;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: kMainColor.withOpacity(0.30),
      ),
      padding: const EdgeInsets.only(
        right: 10,
      ),
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              bottomLeft: Radius.circular(16),
            ),
            child: Image.memory(
              disease.imageBytes,
              width: 110,
              height: 110,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              disease.originName,
              style: Styles.textStyle15.copyWith(
                color: kMainColor,
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: () {},
            child: const Icon(
              Icons.cancel,
              color: kMainColor,
            ),
          )
        ],
      ),
    );
  }
}
