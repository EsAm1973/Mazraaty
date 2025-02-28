part of 'library_cubit.dart';

@immutable
sealed class LibraryState {}

final class LibraryInitial extends LibraryState {}

class LibraryLoading extends LibraryState {}

class LibrarySuccess extends LibraryState {
  final List<PlantCategory> categories;
  final List<Plant> selectedPlants;
  LibrarySuccess(this.categories, this.selectedPlants);
}

class LibraryError extends LibraryState {
  final String errorMessage;
  LibraryError({required this.errorMessage});
}
