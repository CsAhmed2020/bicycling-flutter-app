import 'package:bicycling_app/apis/api_managers/auth_api_manager.dart';
import 'package:bicycling_app/features/auth/otp/bloc/otp_bloc.dart';
import 'package:bicycling_app/utils/preferences/preferences_manager.dart';

abstract class BaseOtpRepository {
  Future<OtpState> requestOTPAgainApi(String uuid);
  Future<OtpState> checkOTPApi(String uuid, String otp);
}

class OtpRepository implements BaseOtpRepository {
  final PreferencesManager preferencesManager;
  final AuthApiManager authApiManager;

  OtpRepository({
    required this.authApiManager,
    required this.preferencesManager,
  });

  @override
  Future<OtpState> requestOTPAgainApi(String uuid) async {
    late OtpState otpState;
    otpState = const RequestOTPAgainApiSuccessfullyState("");
    /*await authApiManager.sendOtpApi(SendOtpModelApi(uuid),
        (sendOtpSuccessfulResponse) {
      otpState = RequestOTPAgainApiSuccessfullyState(
          sendOtpSuccessfulResponse.message);
    }, (errorApiModel) {
      otpState = OtpErrorState(
          errorApiModel.message, errorApiModel.isMessageLocalizationKey);
    });*/
    return otpState;
  }

  @override
  Future<OtpState> checkOTPApi(String uuid, String otpCode) async {
    late OtpState otpState;
    otpState = const CheckOTPApiSuccessfullyState("");
    /*await authApiManager.checkOtpApi(CheckOtpModelApi(otpCode, uuid),
        (sendOtpSuccessfulResponse) {
      otpState =
          CheckOTPApiSuccessfullyState(sendOtpSuccessfulResponse.message);
    }, (errorApiModel) {
      otpState = OtpErrorState(
          errorApiModel.message, errorApiModel.isMessageLocalizationKey);
    });*/

    return otpState;
  }
}
