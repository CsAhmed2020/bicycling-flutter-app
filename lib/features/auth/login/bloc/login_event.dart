part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ForgotPasswordClickedEvent extends LoginEvent {
  @override
  List<Object> get props => [identityHashCode(this)];
}

class SignUpClickedEventEvent extends LoginEvent {
  @override
  List<Object> get props => [identityHashCode(this)];
}

class ValidatePhonePasswordEvent extends LoginEvent {
  final GlobalKey<FormState> loginFormKey;
  ValidatePhonePasswordEvent(this.loginFormKey);
  @override
  List<Object> get props => [identityHashCode(this)];
}

class LoginWithPhonePasswordEvent extends LoginEvent {
  final String email;
  final String password;

  LoginWithPhonePasswordEvent(this.email, this.password);
  @override
  List<Object> get props => [email, password];
}


class StartWhatsAppSessionEvent extends LoginEvent {
  StartWhatsAppSessionEvent();
  @override
  List<Object> get props => [identityHashCode(this)];
}

class SetAsLoggedUserEvent extends LoginEvent {
  @override
  List<Object> get props => [];
}

class SaveTokenDataEvent extends LoginEvent {
  final String loginSuccessfulResponse;

  SaveTokenDataEvent(this.loginSuccessfulResponse);
  @override
  List<Object> get props => [loginSuccessfulResponse];
}

class GetUserInfoApiEvent extends LoginEvent {
  GetUserInfoApiEvent();
  @override
  List<Object> get props => [identityHashCode(this)];
}

class SaveUserInfoEvent extends LoginEvent {
  final String profileInfoApiModel;
  SaveUserInfoEvent(this.profileInfoApiModel);
  @override
  List<Object> get props => [profileInfoApiModel];
}
