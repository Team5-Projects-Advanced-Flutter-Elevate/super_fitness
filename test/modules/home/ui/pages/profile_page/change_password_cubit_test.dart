import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/modules/home/domain/entities/change_password/change_password_response_entity.dart';
import 'package:super_fitness/modules/home/domain/use_cases/change_password/change_password_use_case.dart';
import 'package:super_fitness/modules/home/ui/view_model/change_password/change_password_states.dart';
import 'package:super_fitness/modules/home/ui/view_model/change_password/change_password_view_model.dart';

import 'change_password_cubit_test.mocks.dart';

@GenerateMocks([ChangePasswordUseCase])
void main() {
  late ChangePasswordUseCase mockChangePasswordUseCase;
  late ChangePasswordViewModel changePasswordViewModel;
  late Object error;
  group('ChangePasswordViewModel', () {
    setUp(() {
      mockChangePasswordUseCase = MockChangePasswordUseCase();
      changePasswordViewModel = ChangePasswordViewModel(
        mockChangePasswordUseCase,
      );
    });

    group('Change Password details', () {
      blocTest(
        'emits loading in which success state when use case returns success',
        build: () => changePasswordViewModel,
        setUp: () {
          final responseModel = ChangePasswordResponseEntity();
          provideDummy<ApiResult<ChangePasswordResponseEntity>>(
            Success<ChangePasswordResponseEntity>(data: responseModel),
          );

          when(
            mockChangePasswordUseCase.call('password', 'newPassword'),
          ).thenAnswer(
            (_) async =>
                Success<ChangePasswordResponseEntity>(data: responseModel),
          );
        },
        act:
            (cubit) =>
                cubit.onIntent(PasswordIntent('password', 'newPassword')),
        expect:
            () => <ChangePasswordState>[
              const ChangePasswordState(
                changePasswordStatus: ChangePasswordStatus.loading,
                initialData: null,
              ),
              const ChangePasswordState(
                changePasswordStatus: ChangePasswordStatus.success,
                initialData: ChangePasswordState(
                  changePasswordStatus: ChangePasswordStatus.success,
                ),
              ),
            ],
      );

      blocTest(
        'emits loading in which error state when use case returns error',
        build: () => changePasswordViewModel,
        setUp: () {
          error = Exception('network error');
          provideDummy<ApiResult<ChangePasswordResponseEntity>>(
            Error<ChangePasswordResponseEntity>(error: error),
          );

          when(mockChangePasswordUseCase.call('', '')).thenAnswer(
            (_) async => Error<ChangePasswordResponseEntity>(error: error),
          );
        },
        act: (cubit) => cubit.onIntent(PasswordIntent('', '')),
        expect:
            () => <ChangePasswordState>[
              const ChangePasswordState(
                changePasswordStatus: ChangePasswordStatus.loading,
                initialData: null,
              ),
              const ChangePasswordState(
                changePasswordStatus: ChangePasswordStatus.error,
                error: "Instance of 'Error<ChangePasswordResponseEntity>'",
                initialData: null,
              ),
            ],
      );
    });
  });
}
