part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class LoginClickedEventEvent extends SignUpEvent {
  @override
  List<Object> get props => [identityHashCode(this)];
}

class ValidateFormEvent extends SignUpEvent {
  final GlobalKey<FormState> signUpFormKey;
  const ValidateFormEvent(this.signUpFormKey);
  @override
  List<Object> get props => [identityHashCode(this)];
}

class SignUpApiEvent extends SignUpEvent {
  final String phoneNumber;
  final String password;
  final String fullName;

  const SignUpApiEvent(this.phoneNumber, this.password, this.fullName);
  @override
  List<Object> get props => [phoneNumber, password, fullName];
}

class SetAsLoggedUserEvent extends SignUpEvent {
  @override
  List<Object> get props => [];
}

class SaveTokenDataEvent extends SignUpEvent {
  final String loginSuccessfulResponse;

  const SaveTokenDataEvent(this.loginSuccessfulResponse);
  @override
  List<Object> get props => [loginSuccessfulResponse];
}
