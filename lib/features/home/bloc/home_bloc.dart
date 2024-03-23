import 'dart:async';

import 'package:bicycling_app/features/home/bloc/home_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';


part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final BaseHomeRepository homeRepository;
  HomeBloc(this.homeRepository) : super(HomeInitial()){
    on<GetScootersLocationsApiEvent>(_getScootersLocationsEvent);
  }

  FutureOr<void> _getScootersLocationsEvent(
      GetScootersLocationsApiEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    emit(await homeRepository.getScootersLocations());
  }
}
