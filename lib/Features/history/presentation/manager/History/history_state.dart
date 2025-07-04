part of 'history_cubit.dart';

sealed class HistoryState extends Equatable {
  const HistoryState();

  @override
  List<Object> get props => [];
}

final class HistoryInitial extends HistoryState {}

class HistoryLoading extends HistoryState {}

class HistorySaving extends HistoryState {}

class HistoryLoaded extends HistoryState {
  final List<HistoryDisease> diseases;

  const HistoryLoaded(this.diseases);
  
  @override
  List<Object> get props => [diseases];
}

class HistoryError extends HistoryState {
  final String message;

  const HistoryError(this.message);
  
  @override
  List<Object> get props => [message];
}

class HistorySaveSuccess extends HistoryState {
  final List<HistoryDisease> diseases;
  final String message;

  const HistorySaveSuccess({required this.diseases, required this.message});
  
  @override
  List<Object> get props => [diseases, message];
}

class HistorySaveError extends HistoryState {
  final List<HistoryDisease> diseases;
  final String errorMessage;

  const HistorySaveError({required this.diseases, required this.errorMessage});
  
  @override
  List<Object> get props => [diseases, errorMessage];
}
