import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/modules/home/domain/entities/change_password/change_password_response_entity.dart';
import 'package:super_fitness/modules/home/domain/repositories_contracts/change_password_repo_contract.dart';
import 'package:super_fitness/modules/home/domain/use_cases/change_password/change_password_use_case.dart';

import 'change_password_test.mocks.dart';

@GenerateMocks([ChangePasswordRepoContract])
void main() {
  group('test LoginRepoImpl', () {
    late ChangePasswordUseCase changePasswordUseCase;
    late ChangePasswordRepoContract changePasswordRepoContract;

    setUp(() {
      changePasswordRepoContract = MockChangePasswordRepoContract();
      changePasswordUseCase = ChangePasswordUseCase(changePasswordRepoContract);
    });
    test(
      'when call Change Password function it should call changePassword from repo',
      () async {
        var result = Success<ChangePasswordResponseEntity>(
          data: ChangePasswordResponseEntity(),
        );

        provideDummy<ApiResult<ChangePasswordResponseEntity>>(result);
        var password = 'Mahmoud@123';
        var newPassword = 'Mahmoud@1234';
        when(
          changePasswordRepoContract.changePassword(password, newPassword),
        ).thenAnswer((_) async => result);
        var actual = await changePasswordUseCase.call(password, newPassword);
        verify(
          changePasswordRepoContract.changePassword(password, newPassword),
        ).called(1);
        expect(actual, equals(result));
      },
    );
  });
}
