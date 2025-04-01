import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mazraaty/Core/errors/failure.dart';
import 'package:mazraaty/Features/scan_plant/data/models/disease_details.dart';
import 'package:mazraaty/Features/scan_plant/data/repos/Disease%20Details%20Repo/disease_details_repo.dart';
part 'disease_details_state.dart';

class DiseaseDetailsCubit extends Cubit<DiseaseDetailsState> {
  final DiseaseRepository diseaseRepository;

  DiseaseDetailsCubit({
    required this.diseaseRepository,
  }) : super(DiseaseDetailsInitial());

  Future<void> getDiseaseDetails(String diseaseName, String token) async {
    emit(DiseaseDetailLoading());
    final Either<Failure, DiseaseDetailsModel> result =
        await diseaseRepository.fetchDiseaseDetails(diseaseName, token);

    result.fold(
      (failure) => emit(DiseaseDetailError(failure.errorMessage)),
      (details) => emit(DiseaseDetailLoaded(details)),
    );
  }
} 
