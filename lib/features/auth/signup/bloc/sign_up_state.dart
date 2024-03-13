part of 'sign_up_bloc.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

class SignUpInitial extends SignUpState {}

class SignUpLoadingState extends SignUpState {}

class SignUpErrorState extends SignUpState {
  final String errorMassage;
  final bool isLocalizationKey;
  const SignUpErrorState(this.errorMassage, this.isLocalizationKey);

  @override
  List<Object> get props => [errorMassage, isLocalizationKey];
}

class FormValidatedState extends SignUpState {
  @override
  List<Object> get props => [identityHashCode(this)];
}

class FormNotValidatedState extends SignUpState {
  @override
  List<Object> get props => [identityHashCode(this)];
}

class SignUpSuccessfullyState extends SignUpState {
  final String authSuccessfulResponse;

  const SignUpSuccessfullyState(this.authSuccessfulResponse);
  @override
  List<Object> get props => [identityHashCode(this)];
}

abstract class SignUpSocialSuccessfullyState extends SignUpState {
  final String loginSuccessfulResponse;
  const SignUpSocialSuccessfullyState(this.loginSuccessfulResponse);
}

class SaveTokenDataSuccessfullyState extends SignUpState {
  @override
  List<Object> get props => [identityHashCode(this)];
}

class OpenSignInScreenState extends SignUpState {
  @override
  List<Object> get props => [identityHashCode(this)];
}

class OpenHomeScreenState extends SignUpState {
  @override
  List<Object> get props => [identityHashCode(this)];
}
