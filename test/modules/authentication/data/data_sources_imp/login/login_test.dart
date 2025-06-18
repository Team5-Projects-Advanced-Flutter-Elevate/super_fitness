import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/modules/authentication/data/api/api_client/auth_api_client.dart';
import 'package:super_fitness/modules/authentication/data/data_sources_imp/login/login.dart';
import 'package:super_fitness/modules/authentication/data/models/login/login.dart';
import 'package:super_fitness/modules/authentication/domain/entities/login/login_data_response_entity.dart';

import 'login_test.mocks.dart';

@GenerateMocks([AuthApiClient])
void main() {
  late LoginOnlineDataSourceImpl loginOnlineDataSourceImpl;
  late MockAuthApiClient mockAuthApiClient;

  setUp(() {
    mockAuthApiClient = MockAuthApiClient();
    loginOnlineDataSourceImpl = LoginOnlineDataSourceImpl(mockAuthApiClient);
  });

  group('LoginOnlineDataSourceImpl', () {
    test('should return Success<LoginEntity> when API call is successful', () async {
      // Arrange
      const email = 'mahmoud@example.com';
      const password = 'test123';

      final user = User(
        id: 'id',
        firstName: 'm',
        lastName: 'l',
        email: 'm',
        gender: 'gender',
        age: 2,
        weight: 79,
        height: 170,
        activityLevel: 'activityLevel',
        goal: 'goal',
        photo: 'photo',
        createdAt: DateTime.parse('2024-01-01T12:00:00Z'),
      );

      final loginModel = LoginModel(
        token: 'token_123',
        user: user,
        message: 'Login success',
      );

      final expectedEntity = loginModel.toEntity();

      when(mockAuthApiClient.login({"email": email, "password": password}))
          .thenAnswer((_) async => loginModel);

      // Act
      final result = await loginOnlineDataSourceImpl.login(email, password);

      // Assert
      expect(result, isA<Success<LoginEntity>>());
      expect((result as Success<LoginEntity>).data, equals(expectedEntity));
    });

    test('should return Error when API call throws', () async {
      // Arrange
      const email = 'error@example.com';
      const password = 'wrongpass';

      final error = Exception("Login failed");

      when(mockAuthApiClient.login({"email": email, "password": password}))
          .thenThrow(error);

      // Act
      final result = await loginOnlineDataSourceImpl.login(email, password);

      // Assert
      expect(result, isA<Error<LoginEntity>>());
      expect((result as Error).error.toString(), contains("Login failed"));
    });
  });
}
