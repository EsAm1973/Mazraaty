import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mazraaty/Core/data/Cubits/User%20Cubit/user_cubit.dart';
import 'package:mazraaty/Features/payment/data/models/package.dart';
import 'package:mazraaty/Features/payment/data/repos/Package%20Repo/package_repo.dart';

part 'packages_state.dart';

class PackagesCubit extends Cubit<PackagesState> {
  final PackagesRepository packagesRepository;
  final UserCubit userCubit;
  String _selectedCurrency = 'USD';

  PackagesCubit({
    required this.packagesRepository,
    required this.userCubit,
  }) : super(PackagesInitial());

  String get selectedCurrency => _selectedCurrency;

  Future<void> getPackages() async {
    emit(PackagesLoading());

    final token = userCubit.currentUser?.token;

    final result = await packagesRepository.getPackages(
      currency: _selectedCurrency,
      token: token,
    );

    result.fold(
      (failure) => emit(PackagesError(errorMessage: failure.errorMessage)),
      (packages) => emit(PackagesLoaded(packages: packages)),
    );
  }

  void setCurrency(String currency) {
    if (_selectedCurrency != currency) {
      _selectedCurrency = currency;
      getPackages();
    }
  }
}
