import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mazraaty/Core/data/Cubits/User%20Cubit/user_cubit.dart';
import 'package:mazraaty/Features/home/data/models/common_disease.dart';
import 'package:mazraaty/Features/home/data/repos/Common%20Disease/common_disease_repo.dart';

part 'common_disease_state.dart';

class CommonDiseaseCubit extends Cubit<CommonDiseaseState> {
  final CommonDiseaseRepository commonDiseaseRepository;
  final UserCubit userCubit;

  CommonDiseaseCubit(this.commonDiseaseRepository, this.userCubit)
      : super(CommonDiseaseInitial());

  Future<void> fetchCommonDiseases() async {
    emit(CommonDiseaseLoading());

    final user = userCubit.currentUser;
    if (user == null) {
      emit(const CommonDiseaseError('User not logged in'));
      return;
    }

    final result = await commonDiseaseRepository.fetchDiseases(user.token);

    result.fold((failure) => emit(CommonDiseaseError(failure.errorMessage)),
        (diseases) => emit(CommonDiseaseLoaded(diseases)));
  }

  Future<void> fetchCommonDiseasesIfUserAvailable() async {
    final user = userCubit.currentUser;
    if (user != null) {
      // Only fetch if we're not already loaded or loading
      if (state is! CommonDiseaseLoaded && state is! CommonDiseaseLoading) {
        await fetchCommonDiseases();
      }
    }
  }
}
