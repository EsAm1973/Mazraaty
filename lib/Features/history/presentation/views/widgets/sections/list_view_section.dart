import 'package:flutter/material.dart';
import 'package:mazraaty/Core/utils/styles.dart';
import 'package:mazraaty/Features/history/presentation/views/widgets/common/empty_state.dart';
import 'package:mazraaty/Features/history/presentation/views/widgets/history_listview.dart';
import 'package:mazraaty/constants.dart';

class ListViewSection extends StatelessWidget {
  final List<dynamic> diseases;

  const ListViewSection({
    super.key,
    required this.diseases,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header with count badge
          Row(
            children: [
              const Icon(
                Icons.format_list_bulleted_rounded,
                color: kMainColor,
                size: 24,
              ),
              const SizedBox(width: 10),
              Text(
                'Your Disease Records',
                style: Styles.textStyle20.copyWith(
                  color: kMainColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: kMainColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${diseases.length} Records',
                  style: Styles.textStyle13.copyWith(
                    color: kMainColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // الحل الرئيسي: إضافة Expanded هنا
          Expanded(
            child: diseases.isEmpty
                ? const EmptyStateWidget(
                    message: 'No disease records found',
                    icon: Icons.healing_rounded,
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: HistoryListView(diseases: diseases),
                  ),
          ),
        ],
      ),
    );
  }
}
