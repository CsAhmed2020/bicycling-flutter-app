import 'package:bicycling_app/apis/api_managers/auth_api_manager.dart';
import 'package:bicycling_app/apis/models/auth/login/login_successful_response.dart';
import 'package:bicycling_app/features/auth/signup/bloc/sign_up_bloc.dart';
import 'package:bicycling_app/utils/preferences/preferences_manager.dart';

abstract class BaseSignUpRepository {
  Future<SignUpState> signUpApi(
      String phoneNumber, String fullName, String password);
  Future<SignUpState> savaTokenData(
      LoginSuccessfulResponse loginSuccessfulResponse);
  Future<SignUpState> setAsLoggedUser();
}

class SignUpRepository implements BaseSignUpRepository {
  final PreferencesManager preferencesManager;
  final AuthApiManager authApiManager;

  SignUpRepository({
    required this.preferencesManager,
    required this.authApiManager});

  @override
  Future<SignUpState> signUpApi(
      String phoneNumber, String fullName, String password) async {
    late SignUpState signUpState;
    signUpState = SignUpSuccessfullyState("authSuccessfulResponse");
    /*await authApiManager.createAccountApi(
        CreateAccountSendModel(fullName, phoneNumber, password),
        (authSuccessfulResponse) async {
      await preferencesManager.setUUID(authSuccessfulResponse.uuid);
      signUpState = SignUpSuccessfullyState("authSuccessfulResponse");
    }, (errorApiModel) {
      signUpState = SignUpErrorState(
          errorApiModel.message, errorApiModel.isMessageLocalizationKey);
    });*/

    return signUpState;
  }

  @override
  Future<SignUpState> savaTokenData(
    LoginSuccessfulResponse loginSuccessfulResponse,
  ) async {
    late SignUpState signUpState;

    await preferencesManager.setTokenData(
        loginSuccessfulResponse.accessToken,
        loginSuccessfulResponse.refreshToken,
        loginSuccessfulResponse.expiration,
        loginSuccessfulResponse.uuid);

    signUpState = SaveTokenDataSuccessfullyState();
    return signUpState;
  }


  @override
  Future<SignUpState> setAsLoggedUser() async {
    late SignUpState signUpState;

    await preferencesManager.setLoggedIn();
    signUpState = OpenHomeScreenState();
    return signUpState;
  }

}
