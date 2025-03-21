import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mazraaty/Core/utils/styles.dart';
import 'package:mazraaty/Features/history/presentation/manager/History/history_cubit.dart';
import 'package:mazraaty/Features/history/presentation/views/widgets/history_listview.dart';
import 'package:mazraaty/constants.dart';

class HistoryViewBody extends StatefulWidget {
  const HistoryViewBody({super.key});

  @override
  State<HistoryViewBody> createState() => _HistoryViewBodyState();
}

class _HistoryViewBodyState extends State<HistoryViewBody> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<HistoryCubit>().loadHistory();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HistoryCubit, HistoryState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is HistoryLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is HistoryError) {
          return Center(child: Text(state.message));
        }

        final diseases = state is HistoryLoaded ? state.diseases : [];
        return Padding(
          padding:
              const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 20),
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
              HistoryListView(
                diseases: diseases,
              ),
            ],
          ),
        );
      },
    );
  }
}
