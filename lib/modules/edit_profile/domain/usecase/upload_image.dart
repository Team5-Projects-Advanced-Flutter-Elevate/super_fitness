import 'dart:io';

import 'package:injectable/injectable.dart';

import '../../../../core/apis/api_result/api_result.dart';
import '../entity/upload_image_response_entity.dart';
import '../repo/upload_image.dart';

@injectable
class UploadImageUseCase {
  UploadImageRepo uploadImageRepo;

  UploadImageUseCase(this.uploadImageRepo);

  Future<ApiResult<UploadImageResponseEntity?>> execute({
    required File imageFile,
  }) => uploadImageRepo.uploadProfileImage(imageFile: imageFile);
}
