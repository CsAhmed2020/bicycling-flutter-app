import 'package:dio/dio.dart';

import '../api_keys.dart';
import '../errors/error_api_model.dart';
import '../models/refresh_token/refresh_token_send_model_api.dart';
import '../models/refresh_token/refresh_token_successful_response.dart';

class RefreshTokenApiManager {
  final Dio dio;

  RefreshTokenApiManager(this.dio);

  Future<void> refreshTokenApi(
      RefreshTokenSendModelApi refreshTokenSendModelApi,
      Future<void> Function(RefreshTokenSuccessfulResponse) success,
      void Function(ErrorApiModel) fail) async {
    await dio
        .post(ApiKeys.currentEnvironment + ApiKeys.refreshTokenUrl,
            data: refreshTokenSendModelApi.toMap())
        .then((response) async {
      Map<String, dynamic> extractedData =
          response.data as Map<String, dynamic>;
      RefreshTokenSuccessfulResponse wrapper =
          RefreshTokenSuccessfulResponse.fromJson(extractedData);
      await success(wrapper);
    }).catchError((onError) {
      fail(ErrorApiModel.identifyError(error: onError));
    });
  }
}
