import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/modules/home/data/api/api_client/home_api_client.dart';
import 'package:super_fitness/modules/home/data/data_sourcs_imp/workout_datasource_impl.dart';
import 'package:super_fitness/modules/home/data/models/workouts/get_all_muscles_group_response.dart';
import 'package:super_fitness/modules/home/data/models/workouts/muscle_group_workouts.dart';
import 'package:super_fitness/modules/home/domain/entities/workouts/muscle_group_workout_response_entity.dart';
import 'package:super_fitness/modules/home/domain/entities/workouts/muscles_group_response_entity.dart';

import 'workout_datasource_impl_test.mocks.dart';

@GenerateMocks([HomeApiClient])
void main() {
  late MockHomeApiClient mockHomeApiClient;
  late WorkoutDatasourceImpl workoutDatasourceImpl;
  setUpAll(() {
    mockHomeApiClient = MockHomeApiClient();
    workoutDatasourceImpl = WorkoutDatasourceImpl(mockHomeApiClient);
  });
  group('WorkoutDatasourceImpl', () {
    group('get muscles group', () {
      test(
        'should return a list<MuscleGroupEntity>? when the http call completes successfully',
        () async {
          //arrange
          final responseModel = GetMusclesGroupResponse(
            musclesGroup: [MusclesGroup(id: '1', name: 'name')],
          );
          when(
            mockHomeApiClient.getMusclesGroup(),
          ).thenAnswer((_) async => responseModel);

          //act
          final result = await workoutDatasourceImpl.getMusclesGroup();

          //assert
          expect(result, isA<Success<List<MuscleGroupEntity>?>>());
          verify(mockHomeApiClient.getMusclesGroup()).called(1);
        },
      );

      test(
        ' should return a Error when the http call completes with an error',
        () async {
          //arrange
          final mockError = Exception('Failed to fetch muscles group');
          when(mockHomeApiClient.getMusclesGroup()).thenThrow(mockError);

          //act
          final result = await workoutDatasourceImpl.getMusclesGroup();

          //assert
          expect(result, isA<Error<List<MuscleGroupEntity>?>>());
          verify(mockHomeApiClient.getMusclesGroup()).called(1);
        },
      );
    });

    group(' get muscles group workouts', () {
      test(
        'should return a list<MuscleEntity>? when the http call completes successfully',
        () async {
          //arrange
          final responseModel = MuscleGroupWorkoutsResponse(
            message: 'success',
            muscleGroup: MuscleGroup(name: 'name', id: '1'),
            muscles: [Muscle(id: '1', name: 'name', image: 'image')],
          );

          when(
            mockHomeApiClient.getMusclesGroupWorkouts('1'),
          ).thenAnswer((_) async => responseModel);

          //act
          final result = await workoutDatasourceImpl.getMuscleGroupWorkouts(
            '1',
          );

          //assert
          expect(result, isA<Success<List<MuscleEntity>?>>());
          verify(mockHomeApiClient.getMusclesGroupWorkouts('1')).called(1);
        },
      );

      test(
        ' should return a Error when the http call completes with an error',
        () async {
          //arrange
          final mockError = Exception('Failed to fetch muscles group');
          when(
            mockHomeApiClient.getMusclesGroupWorkouts('1'),
          ).thenThrow(mockError);

          //act
          final result = await workoutDatasourceImpl.getMuscleGroupWorkouts(
            '1',
          );

          //assert
          expect(result, isA<Error<List<MuscleEntity>?>>());
          verify(mockHomeApiClient.getMusclesGroupWorkouts('1')).called(1);
        },
      );
    });
  });
}
