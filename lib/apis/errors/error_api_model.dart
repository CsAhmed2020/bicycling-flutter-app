import 'package:dio/dio.dart';

import '../../utils/build_type/build_type.dart';
import '../models/_base/details_model.dart';
import '../models/auth/login/login_fail_response.dart';
import 'error_api_helper.dart';
import 'locale_dio_exceptions.dart';

class ErrorApiModel {
  final bool isMessageLocalizationKey;
  final String message;
  final int code;
  ErrorApiModel({
    required this.isMessageLocalizationKey,
    required this.message,
    required this.code,
  });

  factory ErrorApiModel.fromDioError(DioException dioError) {
    late int codeError;
    switch (dioError.type) {
      case DioExceptionType.cancel:
        codeError = 1001;
        break;
      case DioExceptionType.connectionTimeout:
        codeError = 1002;
        break;
      case DioExceptionType.receiveTimeout:
        codeError = 1003;
        break;
      case DioExceptionType.badResponse:
        if (dioError.response?.statusCode == 400) {
          codeError = 400;

          return ErrorApiModel.fromResponse(dioError);
        }
        // use code from 1004 - 1010
        codeError = ErrorApiHelper.handleResponseErrorCode(
          dioError.response?.statusCode,
        );
        break;
      case DioExceptionType.sendTimeout:
        codeError = 1011;
        break;
      case DioExceptionType.badCertificate:
        codeError = 1013;
        break;
      case DioExceptionType.connectionError:
        break;
      case DioExceptionType.unknown:
        if (dioError.message?.contains("SocketException") ?? false) {
          codeError = 1012;
          break;
        }
        codeError = 1014;
        break;
      default:
        codeError = 1014;
    }

    return ErrorApiModel(
        code: codeError,
        isMessageLocalizationKey: true,
        message: LocaleDioExceptions.getLocaleMessage(codeError));
  }
  factory ErrorApiModel.identifyError({required dynamic error}) {
    ErrorApiModel errorApiModel;
    if (error is DioException) {
      errorApiModel = ErrorApiModel.fromDioError(error);
    } else if (error is TypeError && isDebugMode()) {
      String? stackTrace = "";
      stackTrace = error.stackTrace.toString();
      errorApiModel = ErrorApiModel(
          code: 1015,
          message:
              ErrorApiHelper.formErrorMessage(error.toString(), stackTrace),
          isMessageLocalizationKey: false);
    } else {
      errorApiModel = ErrorApiModel(
          code: 1014,
          message: LocaleDioExceptions.getLocaleMessage(1014),
          isMessageLocalizationKey: true);
    }
    return errorApiModel;
  }

  factory ErrorApiModel.fromLoginJson(DioException error) {
    Map<String, dynamic> extractedData =
        error.response?.data as Map<String, dynamic>;
    return LoginFailResponse.fromJson(extractedData);
  }
  factory ErrorApiModel.fromResponse(DioException error) {
    Map<String, dynamic> extractedData =
        error.response?.data as Map<String, dynamic>;
    return ErrorApiModel(
        code: error.response?.statusCode ?? 1007,
        message: extractedData["message"] ?? "NO MESSAGE",
        isMessageLocalizationKey: false);
  }

  factory ErrorApiModel.fromDetailsModel(DetailsModel detailsModel) =>
      ErrorApiModel(
          code: detailsModel.statusCode ?? 0,
          message: detailsModel.message ?? "NO MESSAGE",
          isMessageLocalizationKey: false);
}
