import 'dart:async';

import 'package:bicycling_app/features/auth/login/bloc/login_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final BaseLoginRepository loginRepository;
  LoginBloc(this.loginRepository) : super(LoginInitialState()) {
    on<StartWhatsAppSessionEvent>(_startWhatsAppSessionEvent);
    on<ValidatePhonePasswordEvent>(_validateEmailPasswordEvent);
    on<LoginWithPhonePasswordEvent>(_loginWithPhonePasswordEvent);
    on<SetAsLoggedUserEvent>(_setAsLoggedUserEvent);
    on<ForgotPasswordClickedEvent>(_forgotPasswordEvent);
    on<SignUpClickedEventEvent>(_signUpClickedEvent);
  }
  FutureOr<void> _validateEmailPasswordEvent(
      ValidatePhonePasswordEvent event, Emitter<LoginState> emit) {
    if (event.loginFormKey.currentState?.validate() ?? false) {
      event.loginFormKey.currentState?.save();
      emit(PhoneAndPasswordValidatedState());
    } else {
      emit(PhoneAndPasswordNotValidatedState());
    }
  }

  FutureOr<void> _loginWithPhonePasswordEvent(
      LoginWithPhonePasswordEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState());
    emit(await loginRepository.loginWithUserNameAndPasswordApi(
        event.email, event.password));
  }


  FutureOr<void> _setAsLoggedUserEvent(
      SetAsLoggedUserEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState());
    emit(await loginRepository.setAsLoggedUser());
  }

  FutureOr<void> _forgotPasswordEvent(
      ForgotPasswordClickedEvent event, Emitter<LoginState> emit) async {
    emit(OpenForgetPasswordScreenState());
  }

  FutureOr<void> _signUpClickedEvent(
      SignUpClickedEventEvent event, Emitter<LoginState> emit) async {
    emit(OpenSignUpScreenState());
  }

  FutureOr<void> _startWhatsAppSessionEvent(
      StartWhatsAppSessionEvent event, Emitter<LoginState> emit) {}
}
