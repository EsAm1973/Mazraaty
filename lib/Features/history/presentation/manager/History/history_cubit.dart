import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mazraaty/Core/data/Cubits/User%20Cubit/user_cubit.dart';
import 'package:mazraaty/Features/history/data/models/history_model.dart';
import 'package:mazraaty/Features/history/data/repos/history_repo.dart';
import 'package:mazraaty/Features/scan_plant/data/models/disease_details.dart';

part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit(this.repository, this.userCubit) : super(HistoryInitial());
  final IHistoryRepository repository;
  final UserCubit userCubit;

  Future<void> loadHistory() async {
    emit(HistoryLoading());

    final user = userCubit.currentUser;
    if (user == null) {
      emit(const HistoryError('User not logged in'));
      return;
    }

    final result = await repository.getHistory(user.token);

    result.fold((failure) => emit(HistoryError(failure.errorMessage)),
        (diseases) => emit(HistoryLoaded(diseases)));
  }

  Future<void> loadHistoryIfUserAvailable() async {
    final user = userCubit.currentUser;
    if (user != null) {
      // Only load if we're not already loaded or loading
      if (state is! HistoryLoaded && state is! HistoryLoading) {
        await loadHistory();
      }
    }
  }

  Future<void> saveDiseaseToHistory(
      DiseaseDetailsModel disease, Uint8List imageBytes) async {
    final user = userCubit.currentUser;
    if (user == null) {
      emit(const HistoryError('User not logged in'));
      return;
    }

    emit(HistorySaving());

    final result = await repository.addDiseaseToHistory(
      disease,
      imageBytes,
      user.token,
    );

    result.fold(
      (failure) {
        emit(HistorySaveError(
          diseases: const [], // or current diseases if you have them
          errorMessage: failure.errorMessage,
        ));
        loadHistory(); // Reload after error
      }, 
      (response) {
        emit(HistorySaveSuccess(
          diseases: const [], // or current diseases if you have them
          message: response.message,
        ));
        loadHistory(); // Reload after success
      }
    );
  }
}

