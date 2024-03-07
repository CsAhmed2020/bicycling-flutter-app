part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class GetXApiEvent extends HomeEvent {
  const GetXApiEvent();

  @override
  List<Object> get props => [identityHashCode(this)];
}

