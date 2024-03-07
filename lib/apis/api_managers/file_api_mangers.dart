

import '../_base/dio_api_manager.dart';
import '../api_keys.dart';
import '../errors/error_api_model.dart';
import '../models/upload_file/send_upload_file_model.dart';
import '../models/upload_file/upload_file_response.dart';

class UploadFileApiManager {
  final DioApiManager dioApiManager;

  UploadFileApiManager(this.dioApiManager);

  Future<void> uploadFile(
      SendUploadFileModel sendUploadFileModel,
      void Function(UploadFileResponse) success,
      void Function(ErrorApiModel) fail,
      {void Function(int, int)? onSendProgress}) async {
    await dioApiManager.dio
        .post(ApiKeys.uploadFileUrl,
            data: await sendUploadFileModel.toMap(),
            onSendProgress: onSendProgress)
        .then((response) {
      List<dynamic> extractedData = response.data as List<dynamic>;
      UploadFileResponse uploadFileResponse =
          UploadFileResponse.fromJson(extractedData.first);
      success(uploadFileResponse);
    }).catchError((error) {
      fail(ErrorApiModel.identifyError(error: error));
    });
  }
}
