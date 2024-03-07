import 'package:dio/dio.dart';

import '../_base/dio_api_manager.dart';
import '../api_keys.dart';
import '../errors/error_api_model.dart';
import '../models/auth/auth_successful_response.dart';
import '../models/auth/login/login_send_model.dart';
import '../models/auth/login/login_successful_response.dart';
import '../models/auth/register/create_account_send_model.dart';


class AuthApiManager {
  final DioApiManager dioApiManager;
  AuthApiManager(this.dioApiManager);

  Future<void> createAccountApi(
      CreateAccountSendModel createAccountSendModel,
      Future<void> Function(AuthSuccessfulResponse) success,
      void Function(ErrorApiModel) fail) async {
    await dioApiManager.dioUnauthorized
        .post(ApiKeys.createAccountUrl, data: createAccountSendModel.toMap())
        .then((response) async {
      Map<String, dynamic> extractedData =
          response.data as Map<String, dynamic>;
      AuthSuccessfulResponse wrapper =
          AuthSuccessfulResponse.fromJson(extractedData);
      await success(wrapper);
    }).catchError((error) {
      fail(ErrorApiModel.identifyError(error: error));
    });
  }


  Future<void> loginApi(
      LoginSendModelApi loginSendModelApi,
      void Function(LoginSuccessfulResponse) success,
      void Function(ErrorApiModel) fail) async {
    await dioApiManager.dioUnauthorized
        .post(ApiKeys.loginUrl, data: loginSendModelApi.toMap())
        .then((response) {
      Map<String, dynamic> extractedData =
          response.data as Map<String, dynamic>;
      LoginSuccessfulResponse wrapper =
          LoginSuccessfulResponse.fromJson(extractedData);
      success(wrapper);
    }).catchError((error) {
      if (error.type == DioExceptionType.badResponse &&
              (error as DioException).response?.statusCode == 400 ||
          (error as DioException).response?.statusCode == 401) {
        fail(ErrorApiModel.fromLoginJson(error));
      } else {
        fail(ErrorApiModel.identifyError(error: error));
      }
    });
  }

}
