part of 'common_disease_cubit.dart';

sealed class CommonDiseaseState extends Equatable {
  const CommonDiseaseState();

  @override
  List<Object> get props => [];
}

final class CommonDiseaseInitial extends CommonDiseaseState {}

final class CommonDiseaseLoading extends CommonDiseaseState {}

final class CommonDiseaseLoaded extends CommonDiseaseState {
  final List<DiseaseModel> diseases;

  const CommonDiseaseLoaded(this.diseases);

  @override
  List<Object> get props => [diseases];
}

final class CommonDiseaseError extends CommonDiseaseState {
  final String message;

  const CommonDiseaseError(this.message);

  @override
  List<Object> get props => [message];
}
