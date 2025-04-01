part of 'points_cubit.dart';

sealed class PointsState extends Equatable {
  const PointsState();

  @override
  List<Object> get props => [];
}

final class PointsInitial extends PointsState {}

class PointsLoading extends PointsState {}

class PointsLoaded extends PointsState {
  final PointsModel points;
  
  const PointsLoaded(this.points);
  
  @override
  List<Object> get props => [points];
}

class PointsError extends PointsState {
  final String message;
  
  const PointsError(this.message);
  
  @override
  List<Object> get props => [message];
} 