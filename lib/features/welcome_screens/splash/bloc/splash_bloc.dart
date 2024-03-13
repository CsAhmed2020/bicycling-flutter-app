import 'dart:async';

import 'package:bicycling_app/features/welcome_screens/splash/bloc/splash_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final BaseSplashRepository splashRepository;
  SplashBloc(this.splashRepository) : super(SplashInitial());

}
