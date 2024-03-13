import 'package:bicycling_app/apis/api_managers/auth_api_manager.dart';
import 'package:bicycling_app/features/auth/forget_password/bloc/forget_password_bloc.dart';
import 'package:bicycling_app/utils/preferences/preferences_manager.dart';


abstract class BaseForgetPasswordRepository {
  Future<ForgetPasswordState> requestOTPApi(String mobile);
  Future<ForgetPasswordState> resetPasswordApi(
      String uuid, String token, String password);
}

class ForgetPasswordRepository implements BaseForgetPasswordRepository {
  final PreferencesManager preferencesManager;
  final AuthApiManager authApiManager;

  ForgetPasswordRepository({
    required this.preferencesManager,
    required this.authApiManager,
  });
  @override
  Future<ForgetPasswordState> requestOTPApi(String mobile) async {
    late ForgetPasswordState forgetPasswordState;

    forgetPasswordState = RequestOTPApiSuccessfullyState("");
    /*await authApiManager.forgetPasswordApi(ForgetPasswordSendModel(mobile),
        (authSuccessfulResponse) {
      forgetPasswordState =
          RequestOTPApiSuccessfullyState(authSuccessfulResponse);
    }, (errorApiModel) {
      forgetPasswordState = ForgetPasswordErrorState(
          errorApiModel.message, errorApiModel.isMessageLocalizationKey);
    });*/

    return forgetPasswordState;
  }

  @override
  Future<ForgetPasswordState> resetPasswordApi(
      String uuid, String token, String password) async {
    late ForgetPasswordState forgetPasswordState;
    forgetPasswordState = ResetPasswordApiSuccessfullyState("");
    /*await authApiManager
        .resetPasswordApi(ResetPasswordSendModelApi(uuid, token, password),
            (authSuccessfulResponse) {
      forgetPasswordState =
          ResetPasswordApiSuccessfullyState(authSuccessfulResponse.message);
    }, (errorApiModel) {
      forgetPasswordState = ForgetPasswordErrorState(
          errorApiModel.message, errorApiModel.isMessageLocalizationKey);
    });*/

    return forgetPasswordState;
  }
}
