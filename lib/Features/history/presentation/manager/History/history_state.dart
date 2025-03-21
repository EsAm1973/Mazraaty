part of 'history_cubit.dart';

sealed class HistoryState extends Equatable {
  const HistoryState();

  @override
  List<Object> get props => [];
}

final class HistoryInitial extends HistoryState {}

class HistoryLoading extends HistoryState {}

class HistoryLoaded extends HistoryState {
  final List<HistoryDisease> diseases;

  HistoryLoaded(this.diseases);
}

class HistoryError extends HistoryState {
  final String message;

  HistoryError(this.message);
}
