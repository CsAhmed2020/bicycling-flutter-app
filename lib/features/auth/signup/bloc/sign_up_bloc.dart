import 'dart:async';

import 'package:bicycling_app/features/auth/signup/bloc/sign_up_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final BaseSignUpRepository signUpRepository;

  SignUpBloc(this.signUpRepository) : super(SignUpInitial()) {
    on<ValidateFormEvent>(_validateFormEvent);
    on<SignUpApiEvent>(_signUpApiEvent);
    on<SaveTokenDataEvent>(_saveTokenDataEvent);
    on<SetAsLoggedUserEvent>(_setAsLoggedUserEvent);
    on<LoginClickedEventEvent>(_signInClickedEvent);
  }

  FutureOr<void> _validateFormEvent(
      ValidateFormEvent event, Emitter<SignUpState> emit) async {
    if (event.signUpFormKey.currentState?.validate() ?? false) {
      event.signUpFormKey.currentState?.save();
      emit(FormValidatedState());
    } else {
      emit(FormNotValidatedState());
    }
  }

  FutureOr<void> _signUpApiEvent(
      SignUpApiEvent event, Emitter<SignUpState> emit) async {
    emit(SignUpLoadingState());
    emit(await signUpRepository.signUpApi(
      event.phoneNumber,
      event.fullName,
      event.password,
    ));
  }

  FutureOr<void> _saveTokenDataEvent(
      SaveTokenDataEvent event, Emitter<SignUpState> emit) async {
    emit(SignUpLoadingState());
    emit(SaveTokenDataSuccessfullyState());
  }

  FutureOr<void> _setAsLoggedUserEvent(
      SetAsLoggedUserEvent event, Emitter<SignUpState> emit) async {
    emit(SignUpLoadingState());
    emit(await signUpRepository.setAsLoggedUser());
  }

  FutureOr<void> _signInClickedEvent(
      LoginClickedEventEvent event, Emitter<SignUpState> emit) async {
    emit(OpenSignInScreenState());
  }
}
