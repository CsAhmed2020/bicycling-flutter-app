part of 'navigation_drawer_bloc.dart';

abstract class NavigationDrawerState extends Equatable {
  const NavigationDrawerState();

  @override
  List<Object> get props => [];
}

class NavigationDrawerInitial extends NavigationDrawerState {}

class HomeClickedSte extends NavigationDrawerState {}

class ProfileClickedSte extends NavigationDrawerState {}

class WishlistClickedSte extends NavigationDrawerState {}

class BookingsClickedSte extends NavigationDrawerState {}
