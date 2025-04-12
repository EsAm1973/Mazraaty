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
      listener: (context, state) {
        if (state is HistorySaveSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        } else if (state is HistorySaveError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage)),
          );
        } else if (state is HistoryError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        if (state is HistoryInitial) {
          // This should only happen briefly on first load
          return const Center(child: CircularProgressIndicator());
        } else if (state is HistoryLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is HistorySaving) {
          // When saving, show current history with a loading indicator at the top
          return Stack(
            children: [
              _buildHistoryContent(context, state is HistoryLoaded ? (state as HistoryLoaded).diseases : []),
              const Positioned(
                top: 10,
                right: 10,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          );
        } else if (state is HistoryLoaded) {
          return _buildHistoryContent(context, state.diseases);
        } else if (state is HistoryError) {
          // Show error with retry button
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Error loading history: ${state.message}',
                  textAlign: TextAlign.center,
                  style: Styles.textStyle16,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => context.read<HistoryCubit>().loadHistory(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kMainColor,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }
        // Fallback for any other state
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildHistoryContent(BuildContext context, List<dynamic> diseases) {
    if (diseases.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/empty_history.png',
              width: 300,
              height: 300,
            ),
            Text(
              'No History Diseases Found',
              style: Styles.textStyle20.copyWith(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      );
    }

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
          const SizedBox(height: 20),
          HistoryListView(diseases: diseases),
        ],
      ),
    );
  }
}
