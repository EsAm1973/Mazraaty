import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mazraaty/Core/data/Cubits/User%20Cubit/user_cubit.dart';
import 'package:mazraaty/Features/scan_plant/data/models/points.dart';
import 'package:mazraaty/Features/scan_plant/data/repos/Points%20Repo/points_repo.dart';

part 'points_state.dart';

class PointsCubit extends Cubit<PointsState> {
  final PointsRepository pointsRepository;
  final UserCubit userCubit;

  PointsCubit({
    required this.pointsRepository,
    required this.userCubit,
  }) : super(PointsInitial());

  /// Fetches user points from the API and updates user state
  Future<void> fetchUserPoints(String token) async {
    emit(PointsLoading());

    final result = await pointsRepository.fetchUserPoints(token);

    result.fold((failure) => emit(PointsError(failure.errorMessage)), (points) {
      // Update points in UserCubit
      _syncPointsWithUserCubit(points.points);
      emit(PointsLoaded(points));
    });
  }

  /// Synchronizes points between PointsCubit and UserCubit
  void _syncPointsWithUserCubit(int newPoints) {
    final currentUser = userCubit.currentUser;
    if (currentUser != null) {
      // Only update if points are different
      if (currentUser.points != newPoints) {
        final updatedUser = currentUser.copyWith(points: newPoints);
        userCubit.saveUser(updatedUser);
      }
    }
  }

  /// Force refreshes the points from the API
  Future<void> refreshPoints() async {
    final currentUser = userCubit.currentUser;
    if (currentUser != null && currentUser.token.isNotEmpty) {
      await fetchUserPoints(currentUser.token);
    }
  }
}
