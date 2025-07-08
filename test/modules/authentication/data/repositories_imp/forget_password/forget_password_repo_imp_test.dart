import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/modules/authentication/data/data_sources_contracts/forget_password/forget_password_remote_data_source.dart';
import 'package:super_fitness/modules/authentication/data/models/forget_password/forget_password_response.dart';
import 'package:super_fitness/modules/authentication/data/repositories_imp/forget_password/forget_password_repo_imp.dart';
import 'forget_password_repo_imp_test.mocks.dart';

@GenerateMocks([ForgetPasswordRemoteDataSource])
void main() {
  group('test ForgetPasswordRepoImpl', () {
    late ForgetPasswordRepoImpl forgetPasswordRepoImpl;
    late ForgetPasswordRemoteDataSource forgetPasswordRemoteDataSource;
    setUp(() {
      forgetPasswordRemoteDataSource = MockForgetPasswordRemoteDataSource();
      forgetPasswordRepoImpl = ForgetPasswordRepoImpl(
        forgetPasswordRemoteDataSource,
      );
    });
    test(
      'when forgetPassword it should call forgetPassword from datasource',
      () async {
        var result = Success<ForgetPasswordResponse>(
          data: ForgetPasswordResponse(),
        );

        provideDummy<ApiResult<ForgetPasswordResponse?>>(result);
        var email = 'mohamed@gmail.com';
        when(
          forgetPasswordRemoteDataSource.forgetPassword(email),
        ).thenAnswer((_) async => result);
        var actual = await forgetPasswordRepoImpl.forgetPassword(email);
        verify(forgetPasswordRemoteDataSource.forgetPassword(email)).called(1);
        expect(actual, equals(result));
      },
    );
    test(
      'when resetPassword it should call resetPassword from datasource',
      () async {
        var result = Success<ForgetPasswordResponse>(
          data: ForgetPasswordResponse(),
        );

        provideDummy<ApiResult<ForgetPasswordResponse?>>(result);
        var email = 'mohamed@gmail.com';
        var code = '123456';
        when(
          forgetPasswordRemoteDataSource.resetPassword(email, code),
        ).thenAnswer((_) async => result);
        var actual = await forgetPasswordRepoImpl.resetPassword(email, code);
        verify(
          forgetPasswordRemoteDataSource.resetPassword(email, code),
        ).called(1);
        expect(actual, equals(result));
      },
    );
    test('when resetCode it should call resetCode from datasource', () async {
      var result = Success<ForgetPasswordResponse>(
        data: ForgetPasswordResponse(),
      );

      provideDummy<ApiResult<ForgetPasswordResponse?>>(result);
      var email = 'mohamed@gmail.com';
      when(
        forgetPasswordRemoteDataSource.resetCode(email),
      ).thenAnswer((_) async => result);
      var actual = await forgetPasswordRepoImpl.resetCode(email);
      verify(forgetPasswordRemoteDataSource.resetCode(email)).called(1);
      expect(actual, equals(result));
    });
  });
}
