import 'dart:async';

import 'package:bicycling_app/features/home/bloc/home_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final BaseHomeRepository homeRepository;
  HomeBloc(this.homeRepository) : super(HomeInitial());


}
