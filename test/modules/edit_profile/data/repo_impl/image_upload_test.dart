import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/modules/edit_profile/data/datasource/upload_image.dart';
import 'package:super_fitness/modules/edit_profile/data/repo_impl/image_upload.dart';
import 'package:super_fitness/modules/edit_profile/domain/entity/upload_image_response_entity.dart';

import 'image_upload_test.mocks.dart';

@GenerateMocks([UploadImageOnlineDataSource])
void main() {
  group('test LoginRepoImpl', () {
    late UploadImageRepoImpl uploadImageRepoImpl;
    late UploadImageOnlineDataSource uploadImageOnlineDataSource;

    setUp(() {
      uploadImageOnlineDataSource = MockUploadImageOnlineDataSource();
      uploadImageRepoImpl = UploadImageRepoImpl(uploadImageOnlineDataSource);
    });
    test(
      'when upload image it should call uploadProfileImage from datasource',
          () async {
        File imageFile = File(r'C:\Users\pc_nu\Downloads\test.png');

        var result = Success<UploadImageResponseEntity>(
            data: UploadImageResponseEntity());

        provideDummy<ApiResult<UploadImageResponseEntity?>>(result);
        when(
            uploadImageOnlineDataSource.uploadProfileImage(imageFile: imageFile)
        ).thenAnswer((_) async => result);
        var actual = await uploadImageRepoImpl.uploadProfileImage(imageFile: imageFile);
        verify(uploadImageOnlineDataSource.uploadProfileImage(imageFile: imageFile)).called(
            1);
        expect(actual, equals(result));
      },
    );
  });
}