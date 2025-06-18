import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/modules/authentication/domain/entities/login/login_data_response_entity.dart';
import 'package:super_fitness/modules/authentication/domain/repo/login/login.dart';
import 'package:super_fitness/modules/authentication/domain/usecase/login/login.dart';

import 'login_test.mocks.dart';

@GenerateMocks([LoginRepo])
void main() {
  group('test LoginRepoImpl', () {
    late LoginUseCase loginUseCase;
    late LoginRepo loginRepo;

    setUp(() {
      loginRepo = MockLoginRepo();
      loginUseCase = LoginUseCase(loginRepo);
    });
    test('when call call function it should call login from repo', () async {
      // TODO: Implement test

      var result = Success<LoginEntity>(data: LoginEntity());

      provideDummy<ApiResult<LoginEntity>>(result);
      var email = 'mahmoud.mohamed.gamal44@gmail.com';
      var password = 'Mahmoud@123';
      when(loginRepo.login(email, password)).thenAnswer((_) async => result);
      var actual = await loginUseCase.call(email, password);
      verify(loginRepo.login(email, password)).called(1);
      expect(actual, equals(result));
    });
  });
}
