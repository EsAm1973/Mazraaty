import 'package:bloc/bloc.dart';
import 'package:mazraaty/Features/plant_library/data/models/plant.dart';
import 'package:mazraaty/Features/plant_library/data/models/plant_category.dart';
import 'package:mazraaty/Features/plant_library/data/repos/library_repo.dart';
import 'package:meta/meta.dart';

part 'library_state.dart';

class LibraryCubit extends Cubit<LibraryState> {
  LibraryCubit(this.plantRepository) : super(LibraryInitial());
  final PlantRepository plantRepository;
  void fetchCategories() async {
    emit(LibraryLoading());
    final result = await plantRepository.fetchCategories();
    result.fold(
      (failure) => emit(LibraryError(errorMessage: failure.errorMessage)),
      (categories) => emit(
          LibrarySuccess(categories, categories.firstOrNull?.plants ?? [])),
    );
  }
}
