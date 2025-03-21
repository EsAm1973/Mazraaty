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
    try {
      final user = userCubit.currentUser;
      if (user == null) {
        emit(HistoryError('User not logged in'));
        return;
      }

      final history = await repository.getHistory(user.id);
      emit(HistoryLoaded(history));
    } catch (e) {
      emit(HistoryError(e.toString()));
    }
  }

  Future<void> toggleDisease(
      DiseaseDetailsModel disease, Uint8List imageBytes) async {
    final user = userCubit.currentUser;
    if (user == null) return;

    final isSaved = await repository.isDiseaseSaved(disease.id, user.id);

    if (isSaved) {
      await repository.removeDiseaseFromHistory(disease.id, user.id);
    } else {
      await repository.addDiseaseToHistory(disease, imageBytes, user.id);
    }

    loadHistory();
  }

  Future<bool> checkSavedStatus(int diseaseId) async {
    final user = userCubit.currentUser;
    if (user == null) return false;

    return await repository.isDiseaseSaved(diseaseId, user.id);
  }
}
