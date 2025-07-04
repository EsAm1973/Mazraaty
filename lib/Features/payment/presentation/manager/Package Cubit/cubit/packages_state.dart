part of 'packages_cubit.dart';

abstract class PackagesState extends Equatable {
  const PackagesState();

  @override
  List<Object?> get props => [];
}

class PackagesInitial extends PackagesState {}

class PackagesLoading extends PackagesState {}

class PackagesLoaded extends PackagesState {
  final List<Package> packages;

  const PackagesLoaded({required this.packages});

  @override
  List<Object?> get props => [packages];
}

class PackagesError extends PackagesState {
  final String errorMessage;

  const PackagesError({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
} 
