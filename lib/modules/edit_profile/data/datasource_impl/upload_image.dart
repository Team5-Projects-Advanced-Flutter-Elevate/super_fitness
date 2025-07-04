import 'dart:io';

import 'package:injectable/injectable.dart';

import '../../../../core/apis/api_executor/api_executor.dart';
import '../../../../core/apis/api_result/api_result.dart';
import '../../domain/entity/upload_image_response_entity.dart';
import '../api/api_client/upload_image_api_client.dart';
import '../datasource/upload_image.dart';
import '../model/upload_image_response.dart';

@Injectable(as: UploadImageOnlineDataSource)
class UploadImageOnlineDataSourceImpl implements UploadImageOnlineDataSource {
  UploadImageApiClient uploadImageApiClient;

  UploadImageOnlineDataSourceImpl(this.uploadImageApiClient);
  @override
  Future<ApiResult<UploadImageResponseEntity?>> uploadProfileImage({
    required File imageFile,
  }) async {
    var apiResult = await ApiExecutor.executeApi(() {
      return uploadImageApiClient.uploadProfileImageWithDio(imageFile);
    });
    switch (apiResult) {
      case Success<UploadImageResponse>():
        return Success(data: apiResult.data.convertIntoEntity());
      case Error<UploadImageResponse>():
        return Error(error: apiResult.error);
    }
  }
}
