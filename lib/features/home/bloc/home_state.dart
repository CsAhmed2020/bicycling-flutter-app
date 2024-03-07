part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();
  @override
  List<Object> get props => [identityHashCode(this)];
}

final class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeErrorState extends HomeState {
  final String errorMassage;
  final bool isLocalizationKey;
  const HomeErrorState(this.errorMassage, this.isLocalizationKey);

  @override
  List<Object> get props => [errorMassage, isLocalizationKey];
}


