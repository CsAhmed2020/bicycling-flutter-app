import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'navigation_drawer_event.dart';
part 'navigation_drawer_state.dart';

class NavigationDrawerBloc
    extends Bloc<NavigationDrawerEvent, NavigationDrawerState> {
  NavigationDrawerBloc() : super(NavigationDrawerInitial()) {
    on<ItemNavigationDrawerClickedEvent>(_itemNavClickedEvt);
  }

  FutureOr<void> _itemNavClickedEvt(ItemNavigationDrawerClickedEvent event,
      Emitter<NavigationDrawerState> emit) {
    switch (event.index) {
      case 1:
        emit(WishlistClickedSte());
        break;
      case 2:
        emit(BookingsClickedSte());
        break;
      case 3:
        emit(ProfileClickedSte());
        break;

      default:
        emit(HomeClickedSte());
    }
  }
}
