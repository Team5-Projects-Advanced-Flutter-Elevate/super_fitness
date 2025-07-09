import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/modules/edit_profile/domain/entity/edit_info.dart';
import 'package:super_fitness/modules/edit_profile/domain/repo/edit_data.dart';
import 'package:super_fitness/modules/edit_profile/domain/usecase/edit_info_usecase.dart';

import 'edit_info_usecase_test.mocks.dart';

@GenerateMocks([EditInfoRepo])
void main() {
  group('test LoginRepoImpl', () {
    late EditInfoUseCase editInfoUseCase;
    late EditInfoRepo editInfoRepo;

    setUp(() {
      editInfoRepo = MockEditInfoRepo();
      editInfoUseCase = EditInfoUseCase(editInfoRepo);
    });
    test(
      'when call call function it should call _editInfoRepo from repo',
      () async {
        var result = Success<EditMyInfoEntity>(data: const EditMyInfoEntity());

        provideDummy<ApiResult<EditMyInfoEntity>>(result);
        var firstName = "Mahmoud";
        var lastName = "Mohamed";
        var email = "mahmoud.mohamed.gamal44@gmail.com";
        var goal = "lose weight";
        var weight = "75";
        var level = "level1";

        when(
          editInfoRepo.editInfo(
            firstName,
            lastName,
            email,
            goal,
            weight,
            level,
          ),
        ).thenAnswer((_) async => result);
        var actual = await editInfoUseCase.call(
          firstName,
          lastName,
          email,
          goal,
          weight,
          level,
        );
        verify(
          editInfoRepo.editInfo(
            firstName,
            lastName,
            email,
            goal,
            weight,
            level,
          ),
        ).called(1);
        expect(actual, equals(result));
      },
    );
  });
}
