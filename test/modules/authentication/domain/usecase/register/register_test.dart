import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/modules/authentication/domain/entities/register/request/register_request_entity.dart';
import 'package:super_fitness/modules/authentication/domain/entities/register/response/register_response_entity.dart';
import 'package:super_fitness/modules/authentication/domain/repositories_contracts/register/register_repo.dart';
import 'package:super_fitness/modules/authentication/domain/use_cases/register/register_use_case.dart';

import 'register_test.mocks.dart';

@GenerateMocks([RegisterRepo])
void main() {
  group('test LoginRepoImpl', () {
    late RegisterUserCase registerUserCase;
    late RegisterRepo registerRepo;

    setUp(() {
      registerRepo = MockRegisterRepo();
      registerUserCase = RegisterUserCase(registerRepo);
    });
    test(
      'when call register function it should call register from repo',
      () async {
        var result = Success<RegisterResponseEntity>(
          data: RegisterResponseEntity(),
        );

        provideDummy<ApiResult<RegisterResponseEntity>>(result);

        var email = 'mahmoud.mohamed.gamal44@gmail.com';
        var password = 'Mahmoud@123';
        var firstName = 'Elevate';
        var lastName = 'Tech';
        var gender = 'male';
        var height = 170;
        var weight = 70;
        var age = 70;
        var goal = 'Gain weight';
        var activityLevel = 'level1';
        final request = RegisterRequestEntity(
          email: email,
          password: password,
          firstName: firstName,
          lastName: lastName,
          gender: gender,
          height: height,
          weight: weight,
          age: age,
          goal: goal,
          activityLevel: activityLevel,
        );
        when(
          registerRepo.register(registerRequestEntity: request),
        ).thenAnswer((_) async => result);
        var actual = await registerUserCase.call(
          registerRequestEntity: request,
        );
        verify(registerRepo.register(registerRequestEntity: request)).called(1);
        expect(actual, equals(result));
      },
    );
  });
}
