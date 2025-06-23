import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/modules/home/pages/workouts_page/data/api/api_client/workout_page_api_client.dart';
import 'package:super_fitness/modules/home/pages/workouts_page/data/datasource_impl/workout_datasource_impl.dart';
import 'package:super_fitness/modules/home/pages/workouts_page/data/models/get_all_muscles_group_response.dart';
import 'package:super_fitness/modules/home/pages/workouts_page/data/models/muscle_group_workouts.dart';
import 'package:super_fitness/modules/home/pages/workouts_page/domain/entities/muscle_group_workout_response_entity.dart';
import 'package:super_fitness/modules/home/pages/workouts_page/domain/entities/muscles_group_response_entity.dart';

import 'workout_datasource_impl_test.mocks.dart';

@GenerateMocks([WorkoutApiClient])
void main() {
  late MockWorkoutApiClient mockWorkoutApiClient;
  late WorkoutDatasourceImpl workoutDatasourceImpl;
  setUpAll(() {
    mockWorkoutApiClient = MockWorkoutApiClient();
    workoutDatasourceImpl = WorkoutDatasourceImpl(mockWorkoutApiClient);
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
            mockWorkoutApiClient.getMusclesGroup(),
          ).thenAnswer((_) async => responseModel);

          //act
          final result = await workoutDatasourceImpl.getMusclesGroup();

          //assert
          expect(result, isA<Success<List<MuscleGroupEntity>?>>());
          verify(mockWorkoutApiClient.getMusclesGroup()).called(1);
        },
      );

      test(
        ' should return a Error when the http call completes with an error',
        () async {
          //arrange
          final mockError = Exception('Failed to fetch muscles group');
          when(mockWorkoutApiClient.getMusclesGroup()).thenThrow(mockError);

          //act
          final result = await workoutDatasourceImpl.getMusclesGroup();

          //assert
          expect(result, isA<Error<List<MuscleGroupEntity>?>>());
          verify(mockWorkoutApiClient.getMusclesGroup()).called(1);
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
            mockWorkoutApiClient.getMusclesGroupWorkouts('1'),
          ).thenAnswer((_) async => responseModel);

          //act
          final result = await workoutDatasourceImpl.getMuscleGroupWorkouts(
            '1',
          );

          //assert
          expect(result, isA<Success<List<MuscleEntity>?>>());
          verify(mockWorkoutApiClient.getMusclesGroupWorkouts('1')).called(1);
        },
      );

      test(
        ' should return a Error when the http call completes with an error',
        () async {
          //arrange
          final mockError = Exception('Failed to fetch muscles group');
          when(
            mockWorkoutApiClient.getMusclesGroupWorkouts('1'),
          ).thenThrow(mockError);

          //act
          final result = await workoutDatasourceImpl.getMuscleGroupWorkouts(
            '1',
          );

          //assert
          expect(result, isA<Error<List<MuscleEntity>?>>());
          verify(mockWorkoutApiClient.getMusclesGroupWorkouts('1')).called(1);
        },
      );
    });
  });
}
