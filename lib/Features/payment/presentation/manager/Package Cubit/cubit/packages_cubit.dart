import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mazraaty/Features/payment/data/models/package.dart';
import 'package:mazraaty/Features/payment/data/repos/Package%20Repo/package_repo.dart';

part 'packages_state.dart';

class PackagesCubit extends Cubit<PackagesState> {
  final PackagesRepository packagesRepository;

  PackagesCubit({required this.packagesRepository}) : super(PackagesInitial());

  Future<void> getPackages() async {
    emit(PackagesLoading());
    
    final result = await packagesRepository.getPackages();
    
    result.fold(
      (failure) => emit(PackagesError(errorMessage: failure.errorMessage)),
      (packages) => emit(PackagesLoaded(packages: packages)),
    );
  }
} 
