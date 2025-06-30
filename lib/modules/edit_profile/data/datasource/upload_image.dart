import 'dart:io';

import '../../../../core/apis/api_result/api_result.dart';
import '../../domain/entity/upload_image_response_entity.dart';

abstract class UploadImageOnlineDataSource {
  Future<ApiResult<UploadImageResponseEntity?>> uploadProfileImage({
    required File imageFile,
  });
}
