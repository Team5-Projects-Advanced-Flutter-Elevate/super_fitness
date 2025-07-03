import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness/modules/authentication/domain/entities/login/login_data_response_entity.dart';
import 'package:super_fitness/modules/home/ui/pages/profile_page/data/models/profile_response.dart';

void main() {
  group('profile response model', () {
    test(
      'toEntity with non-null values should return ProfileEntity with all fields',
      () {
        //arrange
        final responseModel = ProfileResponse(
          message: 'success',
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

        //act
        var result = responseModel.user?.toEntity();
        var jsonResult = responseModel.toJson();
        // verify that all fields are not null
        jsonResult.forEach((key, value) => expect(value, isNotNull));

        // assert
        expect(result, isA<UserEntity>());
      },
    );
  });
}
