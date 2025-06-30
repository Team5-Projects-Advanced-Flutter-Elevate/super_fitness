import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/modules/authentication/domain/entities/login/login_data_response_entity.dart';
import 'package:super_fitness/modules/home/ui/pages/profile_page/data/api/api_client/profile_api_client.dart';
import 'package:super_fitness/modules/home/ui/pages/profile_page/data/datasource_impl/profile_datasource_impl.dart';
import 'package:super_fitness/modules/home/ui/pages/profile_page/data/models/profile_response.dart';

import 'profile_datasource_impl_test.mocks.dart';

@GenerateMocks([ProfileApiClient])
void main() {
  late ProfileDatasourceImpl profileDatasourceImpl;
  late MockProfileApiClient mockProfileApiClient;
  setUpAll(() {
    mockProfileApiClient = MockProfileApiClient();
    profileDatasourceImpl = ProfileDatasourceImpl(mockProfileApiClient);
  });
  group('profile repo impl', () {
    group('get profile data ', () {
      test(
        'should return an user entity when the http call completes successfully',
        () async {
          //arrange
          final responseModel = ProfileResponse(
            user: UserDM(
              id: '1',
              firstName: 'name',
              email: 'email',
              gender: 'male',
              age: 20,
              weight: 20,
              height: 20,
              activityLevel: 'active',
              goal: 'gain weight',
              photo: 'photo',
              lastName: 'name',
            ),
          );
          when(
            mockProfileApiClient.getProfile(),
          ).thenAnswer((_) async => responseModel);
          //act
          final result = await profileDatasourceImpl.getProfile();
          //assert
          expect(result, isA<Success<UserEntity?>>());
          verify(mockProfileApiClient.getProfile()).called(1);
        },
      );

      test(
        'should return an error when the http call completes with an error',
        () async {
          //arrange
          when(mockProfileApiClient.getProfile()).thenThrow(Exception());
          //act
          final result = await profileDatasourceImpl.getProfile();
          //assert
          expect(result, isA<Error<UserEntity?>>());
          verify(mockProfileApiClient.getProfile()).called(1);
        },
      );
    });
  });
}
