import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/modules/edit_profile/domain/entity/get_data_entity.dart';
import 'package:super_fitness/modules/edit_profile/domain/repo/get_data_repo.dart';
import 'package:super_fitness/modules/edit_profile/domain/usecase/get_data_usecase.dart';

import 'get_data_usecase_test.mocks.dart';

@GenerateMocks([GetLoggedDriverDataRepo])
void main() {
  group('test LoginRepoImpl', () {
    late GetUserDataUseCase getUserDataUseCase;
    late GetLoggedDriverDataRepo getLoggedDriverDataRepo;

    setUp(() {
      getLoggedDriverDataRepo = MockGetLoggedDriverDataRepo();
      getUserDataUseCase = GetUserDataUseCase(getLoggedDriverDataRepo);
    });
    test(
      'when call call function it should call _loggedDriverDataRepo from repo',
      () async {
        var result = Success<GetDataEntity>(data: const GetDataEntity());

        provideDummy<ApiResult<GetDataEntity>>(result);

        when(
          getLoggedDriverDataRepo.getLoggedDriverData(),
        ).thenAnswer((_) async => result);
        var actual = await getUserDataUseCase.call();
        verify(getLoggedDriverDataRepo.getLoggedDriverData()).called(1);
        expect(actual, equals(result));
      },
    );
  });
}
