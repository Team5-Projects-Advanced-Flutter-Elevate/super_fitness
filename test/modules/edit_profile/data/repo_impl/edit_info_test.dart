import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/modules/edit_profile/data/datasource/edit_info.dart';
import 'package:super_fitness/modules/edit_profile/data/repo_impl/edit_info.dart';
import 'package:super_fitness/modules/edit_profile/domain/entity/edit_info.dart';

import 'edit_info_test.mocks.dart';

@GenerateMocks([EditInfoOnlineDataSource])
void main() {
  group('test LoginRepoImpl', () {
    late EditInfoRepoImpl editInfoRepoImpl;
    late EditInfoOnlineDataSource editInfoOnlineDataSource;

    setUp(() {
      editInfoOnlineDataSource = MockEditInfoOnlineDataSource();
      editInfoRepoImpl = EditInfoRepoImpl(editInfoOnlineDataSource);
    });
    test('when edit profile it should call editInfo from datasource', () async {
      // TODO: Implement test

      // var result=Success<LoginEntity>([LoginEntity()]);
      var result = Success<EditMyInfoEntity>(data: const EditMyInfoEntity());

      provideDummy<ApiResult<EditMyInfoEntity>>(result);
      var firstName = "Mahmoud";
      var lastName = "Mohamed";
      var email = "mahmoud.mohamed.gamal44@gmail.com";
      var goal = "lose weight";
      var weight = "75";
      var level = "level1";
      when(
        editInfoOnlineDataSource.editInfo(
          firstName,
          lastName,
          email,
          goal,
          weight,
          level,
        ),
      ).thenAnswer((_) async => result);
      var actual = await editInfoRepoImpl.editInfo(
        firstName,
        lastName,
        email,
        goal,
        weight,
        level,
      );
      verify(
        editInfoOnlineDataSource.editInfo(
          firstName,
          lastName,
          email,
          goal,
          weight,
          level,
        ),
      ).called(1);
      expect(actual, equals(result));
    });
  });
}
