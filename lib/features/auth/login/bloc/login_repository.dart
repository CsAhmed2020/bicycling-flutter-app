

import 'package:bicycling_app/apis/models/auth/login/login_successful_response.dart';

import '../../../../apis/api_managers/auth_api_manager.dart';
import '../../../../utils/preferences/preferences_manager.dart';
import 'login_bloc.dart';

abstract class BaseLoginRepository {
  Future<LoginState> loginWithUserNameAndPasswordApi(
      String userName, String password);
  Future<LoginState> savaTokenData(
      LoginSuccessfulResponse loginSuccessfulResponse);
  Future<LoginState> setAsLoggedUser();

}

class LoginRepository implements BaseLoginRepository {
  final AuthApiManager authApiManager;


  final PreferencesManager preferencesManager;

  LoginRepository({
    required this.preferencesManager,
    required this.authApiManager,
  });

  @override
  Future<LoginState> loginWithUserNameAndPasswordApi(
      String userName, String password) async {
    late LoginState loginState;
    loginState = LoginWithPhoneSuccessfullyState("loginWrapper");
    /*await authApiManager.loginApi(LoginSendModelApi(userName, password, deviceToken), (loginWrapper) {
      loginState = LoginWithPhoneSuccessfullyState(loginWrapper);
    }, (errorApiModel) {
      if (errorApiModel is LoginFailResponse) {
        loginState = LoginFailState(errorApiModel, false);
      } else {
        loginState = LoginErrorState(
            errorApiModel.message, errorApiModel.isMessageLocalizationKey);
      }
    });*/

    return loginState;
  }

  @override
  Future<LoginState> savaTokenData(
    LoginSuccessfulResponse loginSuccessfulResponse,
  ) async {
    late LoginState loginState;

    await preferencesManager.setTokenData(
        loginSuccessfulResponse.accessToken,
        loginSuccessfulResponse.refreshToken,
        loginSuccessfulResponse.expiration,
        loginSuccessfulResponse.uuid);

    loginState = SaveTokenDataSuccessfullyState();
    return loginState;
  }



  @override
  Future<LoginState> setAsLoggedUser() async {
    late LoginState loginState;

    await preferencesManager.setLoggedIn();
    loginState = OpenHomeScreenState();
    return loginState;
  }
}
