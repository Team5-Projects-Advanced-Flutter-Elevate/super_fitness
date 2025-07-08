import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/modules/authentication/data/models/forget_password/forget_password_response.dart';
import 'package:super_fitness/modules/authentication/domain/use_cases/forget_password/forget_password_use_case.dart';
import 'package:super_fitness/modules/authentication/domain/use_cases/forget_password/reset_code_use_case.dart';
import 'package:super_fitness/modules/authentication/domain/use_cases/forget_password/reset_password_use_case.dart';
import 'package:super_fitness/modules/authentication/ui/forget_password/view_model/forget_password_state.dart';
import 'package:super_fitness/modules/authentication/ui/forget_password/view_model/forget_password_view_model.dart';
import 'forget_password_cubit_test.mocks.dart';

@GenerateMocks([ForgetPasswordUseCase, ResetPasswordUseCase, ResetCodeUseCase])
void main() {
  setUpAll(() {
    provideDummy<ApiResult<ForgetPasswordResponse?>>(
      Success<ForgetPasswordResponse?>(data: null),
    );
  });
  TestWidgetsFlutterBinding.ensureInitialized();
  group('ForgetPasswordViewModel', () {
    late ForgetPasswordViewModel forgetPasswordViewModel;
    late ResetCodeUseCase mockResetCodeUseCase;
    late ResetPasswordUseCase mockResetPasswordUseCase;
    late ForgetPasswordUseCase mockForgetPasswordUseCase;

    setUp(() {
      mockResetCodeUseCase = MockResetCodeUseCase();
      mockResetPasswordUseCase = MockResetPasswordUseCase();
      mockForgetPasswordUseCase = MockForgetPasswordUseCase();

      when(mockForgetPasswordUseCase.call('mohamed@gmail.com')).thenAnswer(
        (_) async => Success<ForgetPasswordResponse>(
          data: ForgetPasswordResponse(
            message: 'Success',
            token: '12345',
            info: 'Info',
          ),
        ),
      );
      when(
        mockResetPasswordUseCase.call('mohamed@gmail.com', 'Mohamed@123'),
      ).thenAnswer(
        (_) async => Success<ForgetPasswordResponse>(
          data: ForgetPasswordResponse(
            message: 'Success',
            token: '12345',
            info: 'Info',
          ),
        ),
      );
      when(mockResetCodeUseCase.call('123456')).thenAnswer(
        (_) async => Success<ForgetPasswordResponse>(
          data: ForgetPasswordResponse(
            message: 'Success',
            token: '12345',
            info: 'Info',
          ),
        ),
      );

      forgetPasswordViewModel = ForgetPasswordViewModel(
        mockResetPasswordUseCase,
        mockForgetPasswordUseCase,
        mockResetCodeUseCase,
      );
    });

    blocTest<ForgetPasswordViewModel, ForgetPasswordState>(
      'emits loading then success state when forget password use case returns success',
      build: () {
        when(mockForgetPasswordUseCase.call('mohamed@gmail.com')).thenAnswer(
          (_) async => Success<ForgetPasswordResponse>(
            data: ForgetPasswordResponse(
              message: 'Success',
              token: '12345',
              info: 'Info',
            ),
          ),
        );
        return forgetPasswordViewModel;
      },
      setUp: () {
        forgetPasswordViewModel.email = "mohamed@gmail.com";
      },
      act: (cubit) => cubit.onIntent(ForgotPasswordIntent()),
      expect:
          () => [
            const ForgetPasswordState(sendEmailStatus: SendEmailStatus.loading),
            const ForgetPasswordState(sendEmailStatus: SendEmailStatus.success),
          ],
    );
    blocTest<ForgetPasswordViewModel, ForgetPasswordState>(
      'emits loading then success state when reset password use case returns success',
      build: () {
        when(
          mockResetPasswordUseCase.call('mohamed@gmail.com', 'Mohamed@123'),
        ).thenAnswer(
          (_) async => Success<ForgetPasswordResponse>(
            data: ForgetPasswordResponse(
              message: 'Success',
              token: '12345',
              info: 'Info',
            ),
          ),
        );
        return forgetPasswordViewModel;
      },
      setUp: () {
        forgetPasswordViewModel.email = "mohamed@gmail.com";
      },
      act: (cubit) => cubit.onIntent(ResetPasswordIntent('Mohamed@123')),
      expect:
          () => [
            const ForgetPasswordState(
              sendEmailStatus: SendEmailStatus.initial,
              sendOtpStatus: SendOtpStatus.initial,
              resetPasswordStatus: ResetPasswordStatus.loading,
              otp: null,
              password: null,
              error: null,
              confirmButtonStatus: ConfirmButtonStatus.disabled,
            ),
            const ForgetPasswordState(
              sendEmailStatus: SendEmailStatus.initial,
              sendOtpStatus: SendOtpStatus.initial,
              resetPasswordStatus: ResetPasswordStatus.success,
              otp: null,
              password: 'Mohamed@123',
              error: null,
              confirmButtonStatus: ConfirmButtonStatus.disabled,
            ),
          ],
    );
    blocTest<ForgetPasswordViewModel, ForgetPasswordState>(
      'emits loading then success state when reset code use case returns success',
      build: () {
        when(mockResetCodeUseCase.call('12345')).thenAnswer(
          (_) async => Success<ForgetPasswordResponse>(
            data: ForgetPasswordResponse(
              message: 'Success',
              token: '12345',
              info: 'Info',
            ),
          ),
        );
        return forgetPasswordViewModel;
      },
      setUp: () {
        forgetPasswordViewModel.otpCode = "12345";
      },
      act: (cubit) => cubit.onIntent(ResetCodeIntent()),
      expect:
          () => [
            const ForgetPasswordState(
              sendEmailStatus: SendEmailStatus.initial,
              sendOtpStatus: SendOtpStatus.loading,
              resetPasswordStatus: ResetPasswordStatus.initial,
              otp: null,
              password: null,
              error: null,
              confirmButtonStatus: ConfirmButtonStatus.disabled,
            ),
            const ForgetPasswordState(
              sendEmailStatus: SendEmailStatus.initial,
              sendOtpStatus: SendOtpStatus.success,
              resetPasswordStatus: ResetPasswordStatus.initial,
              otp: '12345',
              password: null,
              error: null,
              confirmButtonStatus: ConfirmButtonStatus.disabled,
            ),
          ],
    );
  });
}
