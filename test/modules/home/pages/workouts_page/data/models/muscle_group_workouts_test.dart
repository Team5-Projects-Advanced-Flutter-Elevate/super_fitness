import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness/modules/home/pages/workouts_page/data/models/muscle_group_workouts.dart';
import 'package:super_fitness/modules/home/pages/workouts_page/domain/entities/muscle_group_workout_response_entity.dart';

void main() {
  group(' MuscleGroupWorkouts ', () {
    test(
      'toEntity with non-null values should return MusclesGroupResponseEntity with all fields',
      () {
        //arrange
        final responseModel = MuscleGroupWorkoutsResponse(
          message: 'success',
          muscleGroup: MuscleGroup(id: '1', name: 'name'),
          muscles: [Muscle(id: '1', name: 'name', image: 'image')],
        );

        //act
        var result = responseModel.toEntity();
        var jsonResult = responseModel.toJson();

        // verify that all fields are not null
        jsonResult.forEach((key, value) => expect(value, isNotNull));

        // assert
        expect(result, isA<MuscleGroupWorkoutsResponseEntity>());
      },
    );

    test(
      'toEntity with null values should return MusclesGroupResponseEntity with null values',
      () {
        // arrange
        final responseModel = MuscleGroupWorkoutsResponse();

        // act
        var result = responseModel.toEntity();
        final jsonResult = responseModel.toJson();

        // verify that all fields are null
        jsonResult.forEach((key, value) => expect(value, isNull));

        // assert
        expect(result, isA<MuscleGroupWorkoutsResponseEntity>());
      },
    );
  });
}
