import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/modules/authentication/data/models/forget_password/forget_password_response.dart';
import 'package:super_fitness/modules/authentication/domain/repositories_contracts/forget_password/forget_password_repo.dart';
import 'package:super_fitness/modules/authentication/domain/use_cases/forget_password/forget_password_use_case.dart';
import 'package:super_fitness/modules/authentication/domain/use_cases/forget_password/reset_code_use_case.dart';
import 'package:super_fitness/modules/authentication/domain/use_cases/forget_password/reset_password_use_case.dart';
import 'forget_password_test.mocks.dart';

@GenerateMocks([ForgetPasswordRepo])
void main() {
  group('test LoginRepoImpl', () {
    late ForgetPasswordUseCase forgetPasswordUseCase;
    late ForgetPasswordRepo forgetPasswordRepo;
    late ResetPasswordUseCase resetPasswordUseCase;
    late ResetCodeUseCase resetCodeUseCase;
    setUp(() {
      forgetPasswordRepo = MockForgetPasswordRepo();
      forgetPasswordUseCase = ForgetPasswordUseCase(forgetPasswordRepo);
      resetPasswordUseCase = ResetPasswordUseCase(forgetPasswordRepo);
      resetCodeUseCase = ResetCodeUseCase(forgetPasswordRepo);
    });
    test(
      'when call forget password function it should call forgetPassword from repo',
      () async {
        var result = Success<ForgetPasswordResponse>(
          data: ForgetPasswordResponse(),
        );

        provideDummy<ApiResult<ForgetPasswordResponse?>>(result);
        var email = 'mohamed@gmail.com';
        when(
          forgetPasswordRepo.forgetPassword(email),
        ).thenAnswer((_) async => result);
        var actual = await forgetPasswordUseCase.call(email);
        verify(forgetPasswordRepo.forgetPassword(email)).called(1);
        expect(actual, equals(result));
      },
    );
    test(
      'when call reset password function it should call resetPassword from repo',
      () async {
        var result = Success<ForgetPasswordResponse>(
          data: ForgetPasswordResponse(),
        );

        provideDummy<ApiResult<ForgetPasswordResponse?>>(result);
        var email = 'mohamed@gmail.com';
        var newPassword = 'Mohamed@1234';
        when(
          forgetPasswordRepo.resetPassword(email, newPassword),
        ).thenAnswer((_) async => result);
        var actual = await resetPasswordUseCase.call(email, newPassword);
        verify(forgetPasswordRepo.resetPassword(email, newPassword)).called(1);
        expect(actual, equals(result));
      },
    );
    test(
      'when call reset code function it should call resetCode from repo',
      () async {
        var result = Success<ForgetPasswordResponse>(
          data: ForgetPasswordResponse(),
        );

        provideDummy<ApiResult<ForgetPasswordResponse?>>(result);
        var code = '123456';
        when(
          forgetPasswordRepo.resetCode(code),
        ).thenAnswer((_) async => result);
        var actual = await resetCodeUseCase.call(code);
        verify(forgetPasswordRepo.resetCode(code)).called(1);
        expect(actual, equals(result));
      },
    );
  });
}
