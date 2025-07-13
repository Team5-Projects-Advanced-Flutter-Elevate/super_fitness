import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/modules/edit_profile/domain/entity/upload_image_response_entity.dart';
import 'package:super_fitness/modules/edit_profile/domain/repo/upload_image.dart';
import 'package:super_fitness/modules/edit_profile/domain/usecase/upload_image.dart';

import 'upload_image_test.mocks.dart';

@GenerateMocks([UploadImageRepo])
void main() {
  group('test LoginRepoImpl', () {
    late UploadImageUseCase uploadImageUseCase;
    late UploadImageRepo uploadImageRepo;

    setUp(() {
      uploadImageRepo = MockUploadImageRepo();
      uploadImageUseCase = UploadImageUseCase(uploadImageRepo);
    });
    test(
      'when call execute function it should call uploadProfileImage from repo',
      () async {
        File imageFile = File(r'C:\Users\pc_nu\Downloads\test.png');

        var result = Success<UploadImageResponseEntity>(
          data: UploadImageResponseEntity(),
        );

        provideDummy<ApiResult<UploadImageResponseEntity?>>(result);
        when(
          uploadImageRepo.uploadProfileImage(imageFile: imageFile),
        ).thenAnswer((_) async => result);
        var actual = await uploadImageUseCase.execute(imageFile: imageFile);
        verify(
          uploadImageRepo.uploadProfileImage(imageFile: imageFile),
        ).called(1);
        expect(actual, equals(result));
      },
    );
  });
}
