import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/modules/home/data/data_sources_contracts/change_password/change_password_remote_data_source_contract.dart';
import 'package:super_fitness/modules/home/data/repositories_imp/change_password/change_password_repo_impl.dart';
import 'package:super_fitness/modules/home/domain/entities/change_password/change_password_response_entity.dart';

import 'change_password_repo_impl_test.mocks.dart';

@GenerateMocks([ChangePasswordRemoteDataSourceContract])
void main() {
  group('test ChangePasswordRepoImpl', () {
    late ChangePasswordRepoImpl changePasswordRepoImpl;
    late ChangePasswordRemoteDataSourceContract
    changePasswordRemoteDataSourceContract;

    setUp(() {
      changePasswordRemoteDataSourceContract =
          MockChangePasswordRemoteDataSourceContract();
      changePasswordRepoImpl = ChangePasswordRepoImpl(
        changePasswordRemoteDataSourceContract,
      );
    });
    test(
      'when change password it should call changePassword from datasource',
      () async {
        var result = Success<ChangePasswordResponseEntity>(
          data: ChangePasswordResponseEntity(),
        );

        provideDummy<ApiResult<ChangePasswordResponseEntity>>(result);
        var password = 'Mahmoud@123';
        var newPassword = 'Mahmoud@1234';
        when(
          changePasswordRemoteDataSourceContract.changePassword(
            password,
            newPassword,
          ),
        ).thenAnswer((_) async => result);
        var actual = await changePasswordRepoImpl.changePassword(
          password,
          newPassword,
        );
        verify(
          changePasswordRemoteDataSourceContract.changePassword(
            password,
            newPassword,
          ),
        ).called(1);
        expect(actual, equals(result));
      },
    );
  });
}
