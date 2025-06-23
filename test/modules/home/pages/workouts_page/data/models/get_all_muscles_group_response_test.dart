import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness/modules/home/pages/workouts_page/data/models/get_all_muscles_group_response.dart';
import 'package:super_fitness/modules/home/pages/workouts_page/domain/entities/muscles_group_response_entity.dart';

void main() {
  group(' GetAllMusclesGroupResponse ', () {
    test(
      'toEntity with non-null values should return MusclesGroupResponseEntity with all fields',
      () {
        //arrange
        final responseModel = GetMusclesGroupResponse(
          message: 'success',
          musclesGroup: [MusclesGroup(id: '1', name: 'name')],
        );

        //act
        var result = responseModel.toEntity();
        var jsonResult = responseModel.toJson();

        // verify that all fields are not null
        jsonResult.forEach((key, value) => expect(value, isNotNull));

        // assert
        expect(result, isA<MusclesGroupResponseEntity>());
      },
    );

    test(
      'toEntity with null values should return MusclesGroupResponseEntity with null values',
      () {
        // arrange
        final responseModel = GetMusclesGroupResponse();

        // act
        final result = responseModel.toEntity();
        final jsonResult = responseModel.toJson();

        // verify that all fields are null
        jsonResult.forEach((key, value) => expect(value, isNull));

        // assert
        expect(result, isA<MusclesGroupResponseEntity?>());
      },
    );
  });
}
