import 'package:bloc/bloc.dart';
import 'package:mazraaty/Features/plant_library/data/models/plant.dart';
import 'package:mazraaty/Features/plant_library/data/models/plant_category.dart';
import 'package:mazraaty/Features/plant_library/data/repos/library_repo.dart';
import 'package:meta/meta.dart';

part 'library_state.dart';

class LibraryCubit extends Cubit<LibraryState> {
  LibraryCubit(this.plantRepository) : super(LibraryInitial());
  final PlantRepository plantRepository;
  List<Plant> allPlants = []; // قائمة بجميع النباتات الأصلية

  void fetchCategories() async {
    emit(LibraryLoading());
    final result = await plantRepository.fetchCategories();
    result.fold(
      (failure) => emit(LibraryError(errorMessage: failure.errorMessage)),
      (categories) {
        // إنشاء كاتيجوري "All" مع جميع النباتات
        allPlants = categories.expand((category) => category.plants).toList();
        final allCategory =
            PlantCategory(id: 0, name: "All", plants: allPlants);
        List<PlantCategory> updatedCategories = [allCategory, ...categories];

        emit(LibrarySuccess(updatedCategories, allPlants, selectedIndex: 0));
      },
    );
  }

  void selectCategory(int categoryIndex, List<PlantCategory> categories) {
    emit(LibrarySuccess(categories, categories[categoryIndex].plants,
        selectedIndex: categoryIndex));
  }

  void searchPlants(String query) {
    final currentState = state;
    if (currentState is LibrarySuccess) {
      if (query.isEmpty) {
        // في حالة عدم وجود نص بحث، نعرض النباتات الأصلية
        emit(LibrarySuccess(
          currentState.categories,
          currentState.categories[currentState.selectedIndex].plants,
          selectedIndex: currentState.selectedIndex,
          searchQuery: '',
        ));
      } else {
        // تصفية النباتات بناءً على البحث
        final filteredPlants = allPlants
            .where((plant) =>
                plant.name.toLowerCase().contains(query.toLowerCase()))
            .toList();

        emit(LibrarySuccess(
          currentState.categories,
          filteredPlants,
          selectedIndex: currentState.selectedIndex,
          searchQuery: query,
        ));
      }
    }
  }
}
