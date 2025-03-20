part of 'disease_details_cubit.dart';

sealed class DiseaseDetailsState extends Equatable {
  const DiseaseDetailsState();

  @override
  List<Object> get props => [];
}

final class DiseaseDetailsInitial extends DiseaseDetailsState {}

class DiseaseDetailLoading extends DiseaseDetailsState {}

class DiseaseDetailLoaded extends DiseaseDetailsState {
  final DiseaseDetailsModel details;
  const DiseaseDetailLoaded(this.details);
}

class DiseaseDetailError extends DiseaseDetailsState {
  final String message;
  const DiseaseDetailError(this.message);
}
