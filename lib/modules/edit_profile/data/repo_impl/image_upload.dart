import 'dart:io';

import 'package:injectable/injectable.dart';

import '../../../../core/apis/api_result/api_result.dart';
import '../../domain/entity/upload_image_response_entity.dart';
import '../../domain/repo/upload_image.dart';
import '../datasource/upload_image.dart';

@Injectable(as: UploadImageRepo)
class UploadImageRepoImpl implements UploadImageRepo {
  UploadImageOnlineDataSource uploadImageOnlineDataSource;
  UploadImageRepoImpl(this.uploadImageOnlineDataSource);

  @override
  Future<ApiResult<UploadImageResponseEntity?>> uploadProfileImage({
    required File imageFile,
  }) {
    return uploadImageOnlineDataSource.uploadProfileImage(imageFile: imageFile);
  }
}
