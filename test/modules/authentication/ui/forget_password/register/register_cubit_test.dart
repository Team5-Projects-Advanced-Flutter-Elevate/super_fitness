import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/core/utilities/google_sign_in/google_sign_in_handler.dart';
import 'package:super_fitness/modules/authentication/data/models/user/user_dto.dart';
import 'package:super_fitness/modules/authentication/domain/entities/register/request/register_request_entity.dart';
import 'package:super_fitness/modules/authentication/domain/entities/register/response/register_response_entity.dart';
import 'package:super_fitness/modules/authentication/domain/entities/user/user_entity.dart';
import 'package:super_fitness/modules/authentication/domain/use_cases/firebase_auth/google/sign_up/sign_up_with_google_account.dart';
import 'package:super_fitness/modules/authentication/domain/use_cases/register/register_use_case.dart';
import 'package:super_fitness/modules/authentication/ui/register/view_model/register_state.dart';
import 'package:super_fitness/modules/authentication/ui/register/view_model/register_view_model.dart';
import 'register_cubit_test.mocks.dart';

@GenerateMocks([
  RegisterUserCase,
  SignUpWithGoogleAccountUseCase,
  GoogleSignInHandler,
  GoogleSignInAccount,
  UserCredential,
])
void main() {
  setUpAll(() {
    provideDummy<ApiResult<RegisterResponseEntity>>(
      Success<RegisterResponseEntity>(
        data: RegisterResponseEntity(
          message: 'Success',
          token: '12345',
          user: UserEntity(
            id: '1',
            firstName: 'Elevate',
            lastName: 'Tech',
            email: 'mohamed@gmail.com',
            gender: 'male',
            age: 70,
            weight: 70,
            height: 170,
            activityLevel: 'level1',
            goal: 'Gain weight',
            photo: 'default-profile.png',
          ),
        ),
      ),
    );
    provideDummy<ApiResult<UserCredential>>(
      Success<UserCredential>(data: MockUserCredential()),
    );
  });
  TestWidgetsFlutterBinding.ensureInitialized();
  group('RegisterViewModel', () {
    late RegisterViewModel registerViewModel;
    late RegisterUserCase mockRegisterUserCase;
    late SignUpWithGoogleAccountUseCase mockSignUpWithGoogleAccountUseCase;
    late GoogleSignInHandler mockGoogleSignInHandler;
    late GoogleSignInAccount googleSignInAccount;
    late UserCredential userCredential;
    setUp(() {
      mockRegisterUserCase = MockRegisterUserCase();
      mockSignUpWithGoogleAccountUseCase = MockSignUpWithGoogleAccountUseCase();
      mockGoogleSignInHandler = MockGoogleSignInHandler();
      googleSignInAccount = MockGoogleSignInAccount();
      userCredential = MockUserCredential();
      when(
        mockRegisterUserCase.call(
          registerRequestEntity: RegisterRequestEntity(
            email: 'mohamed@gmail.com',
            password: 'Mohamed@123',
            firstName: 'Elevate',
            lastName: 'Tech',
            gender: 'male',
            height: 170,
            weight: 70,
            age: 70,
            goal: 'Gain weight',
            activityLevel: 'level1',
          ),
        ),
      ).thenAnswer(
        (_) async => Success<RegisterResponseEntity>(
          data: RegisterResponseEntity(
            message: 'Success',
            token: '12345',
            user: UserEntity(
              id: '1',
              firstName: 'Elevate',
              lastName: 'Tech',
              email: 'mohamed@gmail.com',
              gender: 'male',
              age: 70,
              weight: 70,
              height: 170,
              activityLevel: 'level1',
              goal: 'Gain weight',
              photo: 'default-profile.png',
            ),
          ),
        ),
      );
      when(
        mockSignUpWithGoogleAccountUseCase.call(
          googleSignInAccount,
          UserDto(
            email: 'mohamed@gmail.com',
            firstName: 'Elevate',
            lastName: 'Tech',
            gender: 'male',
            age: 70,
            weight: 70,
            height: 170,
            goal: 'Gain weight',
            activityLevel: 'level1',
          ),
        ),
      ).thenAnswer((_) async => Success<UserCredential>(data: userCredential));
      when(
        mockGoogleSignInHandler.getUserGoogleAccount(),
      ).thenAnswer((_) async => googleSignInAccount);
      registerViewModel = RegisterViewModel(
        mockRegisterUserCase,
        mockSignUpWithGoogleAccountUseCase,
        mockGoogleSignInHandler,
      );
    });
    blocTest<RegisterViewModel, RegisterState>(
      'emits loading then success state when register use case returns success',
      build: () {
        when(
          mockRegisterUserCase.call(
            registerRequestEntity: RegisterRequestEntity(
              email: 'mohamed@gmail.com',
              password: 'Mohamed@123',
              firstName: 'Elevate',
              lastName: 'Tech',
              gender: 'male',
              height: 170,
              weight: 70,
              age: 70,
              goal: 'Gain weight',
              activityLevel: 'level1',
            ),
          ),
        ).thenAnswer(
          (_) async => Success<RegisterResponseEntity>(
            data: RegisterResponseEntity(
              message: 'Success',
              token: '12345',
              user: UserEntity(
                id: '1',
                firstName: 'Elevate',
                lastName: 'Tech',
                email: 'mohamed@gmail.com',
                gender: 'male',
                age: 70,
                weight: 70,
                height: 170,
                activityLevel: 'level1',
                goal: 'Gain weight',
                photo: 'default-profile.png',
              ),
            ),
          ),
        );
        return registerViewModel;
      },
      act:
          (cubit) => cubit.doIntent(
            RegisterUser(
              restOfRegisterRequest: RestOfRegisterRequest(
                gender: 'male',
                age: 70,
                weight: 70,
                height: 170,
                goal: 'Gain weight',
                activityLevel: 'level1',
              ),
            ),
          ),
      expect: () => [],
    );
    blocTest<RegisterViewModel, RegisterState>(
      'emits loading then error state when register use case returns error',
      build: () {
        when(
          mockRegisterUserCase.call(
            registerRequestEntity: RegisterRequestEntity(
              email: 'mohamed@gmail.com',
              password: 'Mohamed@123',
              firstName: 'Elevate',
              lastName: 'Tech',
              gender: 'male',
              height: 170,
              weight: 70,
              age: 70,
              goal: 'Gain weight',
              activityLevel: 'level1',
            ),
          ),
        ).thenAnswer(
          (_) async => Success<RegisterResponseEntity>(
            data: RegisterResponseEntity(
              message: 'Success',
              token: '12345',
              user: UserEntity(
                id: '1',
                firstName: 'Elevate',
                lastName: 'Tech',
                email: 'mohamed@gmail.com',
                gender: 'male',
                age: 70,
                weight: 70,
                height: 170,
                activityLevel: 'level1',
                goal: 'Gain weight',
                photo: 'default-profile.png',
              ),
            ),
          ),
        );
        return registerViewModel;
      },
      act:
          (cubit) => cubit.doIntent(
            RegisterUser(
              restOfRegisterRequest: RestOfRegisterRequest(
                gender: 'male',
                age: 70,
                weight: 70,
                height: 170,
                goal: 'Gain weight',
                activityLevel: 'level1',
              ),
            ),
          ),
      expect: () => [],
    );
  });
}
