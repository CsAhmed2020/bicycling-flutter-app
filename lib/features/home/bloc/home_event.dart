part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class GetScootersLocationsApiEvent extends HomeEvent {
  const GetScootersLocationsApiEvent();

  @override
  List<Object> get props => [identityHashCode(this)];
}

