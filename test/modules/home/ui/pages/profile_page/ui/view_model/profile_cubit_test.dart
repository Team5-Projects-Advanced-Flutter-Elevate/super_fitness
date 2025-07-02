import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/modules/authentication/domain/entities/login/login_data_response_entity.dart';
import 'package:super_fitness/modules/authentication/domain/usecase/login/login_local.dart';
import 'package:super_fitness/modules/home/ui/pages/profile_page/domain/use_cases/get_profile_data.dart';
import 'package:super_fitness/modules/home/ui/pages/profile_page/ui/view_model/profile_cubit.dart';
import 'profile_cubit_test.mocks.dart';

@GenerateMocks([GetProfileDataUseCase, StoreLoginLocalUseCase])
void main() {
  late MockGetProfileDataUseCase mockGetProfileDataUseCase;
  late MockStoreLoginLocalUseCase mockStoreLoginLocalUseCase;
  late ProfileCubit profileCubit;
  late Object getProfileDataError;
  late UserEntity userEntity;
  setUp(() {
    mockGetProfileDataUseCase = MockGetProfileDataUseCase();
    mockStoreLoginLocalUseCase = MockStoreLoginLocalUseCase();
    profileCubit = ProfileCubit(
      mockGetProfileDataUseCase,
      mockStoreLoginLocalUseCase,
    );
  });
  group('profile cubit', () {
    group('get profile data', () {
      blocTest(
        'emit loading → success state when use case returns success',
        build: () => profileCubit,
        setUp: () {
          userEntity = UserEntity(
            id: '1',
            email: 'email',
            gender: 'gender',
            age: 10,
            weight: 100,
            lastName: 'lastName',
            firstName: 'firstName',
            height: 100,
            activityLevel: 'activityLevel',
            goal: 'goal',
            photo: 'photo',
            createdAt: DateTime.now(),
          );
          provideDummy<ApiResult<UserEntity?>>(
            Success<UserEntity?>(data: userEntity),
          );
          when(
            mockGetProfileDataUseCase.execute(),
          ).thenAnswer((_) async => Success<UserEntity?>(data: userEntity));
        },
        act: (cubit) => cubit.doIntent(GetProfileDataIntent()),
        expect:
            () => [
              const ProfileState(status: ProfileStatus.loading),
              ProfileState(
                status: ProfileStatus.success,
                userEntity: userEntity,
              ),
            ],
      );
      blocTest(
        'emit loading → error state when use case returns error',
        build: () => profileCubit,
        setUp: () {
          getProfileDataError = Exception('error');
          provideDummy<ApiResult<UserEntity?>>(
            Error<UserEntity?>(error: getProfileDataError),
          );
          when(mockGetProfileDataUseCase.execute()).thenAnswer(
            (_) async => Error<UserEntity?>(error: getProfileDataError),
          );
        },
        act: (cubit) => cubit.doIntent(GetProfileDataIntent()),
        expect:
            () => [
              const ProfileState(status: ProfileStatus.loading),
              ProfileState(
                status: ProfileStatus.error,
                getProfileError: getProfileDataError,
              ),
            ],
      );
    });
  });
}
