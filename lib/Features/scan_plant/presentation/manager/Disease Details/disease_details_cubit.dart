import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mazraaty/Core/data/Cubits/User%20Cubit/user_cubit.dart';
import 'package:mazraaty/Core/errors/failure.dart';
import 'package:mazraaty/Features/scan_plant/data/models/disease_details.dart';
import 'package:mazraaty/Features/scan_plant/data/repos/Disease%20Details%20Repo/disease_details_repo.dart';
part 'disease_details_state.dart';

class DiseaseDetailsCubit extends Cubit<DiseaseDetailsState> {
  final DiseaseRepository diseaseRepository;
  final UserCubit userCubit; // أضف هذا السطر

  DiseaseDetailsCubit({
    required this.diseaseRepository,
    required this.userCubit, // أضف هذا الباراميتر
  }) : super(DiseaseDetailsInitial());

  Future<void> getDiseaseDetails(String diseaseName, String token) async {
    emit(DiseaseDetailLoading());
    final Either<Failure, DiseaseDetailsModel> result =
        await diseaseRepository.fetchDiseaseDetails(diseaseName, token);

    result.fold(
      (failure) => emit(DiseaseDetailError(failure.errorMessage)),
      (details) {
        // حفظ النقاط الجديدة هنا ↓
        _updateUserPoints(details.userPoints);
        emit(DiseaseDetailLoaded(details));
      },
    );
  }

  void _updateUserPoints(int? newPoints) {
    final currentUser = userCubit.currentUser;
    if (currentUser != null) {
      final updatedUser = currentUser.copyWith(points: newPoints);
      userCubit.saveUser(updatedUser);
    }
  }
}
