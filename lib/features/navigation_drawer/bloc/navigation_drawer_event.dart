part of 'navigation_drawer_bloc.dart';

abstract class NavigationDrawerEvent extends Equatable {
  const NavigationDrawerEvent();

  @override
  List<Object> get props => [];
}

class ItemNavigationDrawerClickedEvent extends NavigationDrawerEvent {
  final int index;

  const ItemNavigationDrawerClickedEvent(this.index);

  @override
  List<Object> get props => [index];
}
