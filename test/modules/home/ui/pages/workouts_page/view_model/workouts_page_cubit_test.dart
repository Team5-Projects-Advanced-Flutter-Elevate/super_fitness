import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/modules/home/data/models/workouts/get_all_muscles_group_response.dart';
import 'package:super_fitness/modules/home/data/models/workouts/muscle_group_workouts.dart';
import 'package:super_fitness/modules/home/domain/entities/workouts/muscle_group_workout_response_entity.dart';
import 'package:super_fitness/modules/home/domain/entities/workouts/muscles_group_response_entity.dart';
import 'package:super_fitness/modules/home/domain/use_cases/workouts/get_muscle_group_workout_use_case.dart';
import 'package:super_fitness/modules/home/domain/use_cases/workouts/get_muscles_group_use_case.dart';
import 'package:super_fitness/modules/home/ui/pages/workouts_page/view_model/workouts_page_cubit.dart';

import 'workouts_page_cubit_test.mocks.dart';

@GenerateMocks([GetMusclesGroupUseCase, GetMuscleGroupWorkoutUseCase])
void main() {
  late WorkoutsPageCubit cubit;
  late MockGetMusclesGroupUseCase getMusclesGroupUseCase;
  late MockGetMuscleGroupWorkoutUseCase getMuscleGroupWorkoutUseCase;
  late Object getMusclesGroupError;
  late Object getMuscleGroupWorkoutsError;
  late GetMusclesGroupResponse getMusclesGroupResponse;
  late MuscleGroupWorkoutsResponse getMuscleGroupWorkoutsResponse;
  setUp(() {
    getMusclesGroupUseCase = MockGetMusclesGroupUseCase();
    getMuscleGroupWorkoutUseCase = MockGetMuscleGroupWorkoutUseCase();
    cubit = WorkoutsPageCubit(
      getMusclesGroupUseCase,
      getMuscleGroupWorkoutUseCase,
    );
  });
  group(' WorkoutsPageCubit ', () {
    group(' get muscles group', () {
      blocTest(
        'emits loading → success state when use case returns success ',
        build: () => cubit,
        setUp: () {
          getMusclesGroupResponse = GetMusclesGroupResponse(
            message: 'success',
            musclesGroup: [MusclesGroup(id: '1', name: 'name')],
          );
          provideDummy<ApiResult<List<MuscleGroupEntity>?>>(
            Success<List<MuscleGroupEntity>?>(
              data: getMusclesGroupResponse.toEntity().musclesGroup,
            ),
          );

          when(getMusclesGroupUseCase.execute()).thenAnswer(
            (_) async => Success<List<MuscleGroupEntity>?>(
              data: getMusclesGroupResponse.toEntity().musclesGroup,
            ),
          );
        },
        act: (cubit) => cubit.doIntent(GetMusclesGroupIntent()),
        expect:
            () => [
              const WorkoutsPageState(
                getMusclesGroupStatus: WorkoutsPageStatus.loading,
              ),
              WorkoutsPageState(
                getMusclesGroupStatus: WorkoutsPageStatus.success,
                musclesGroup: getMusclesGroupResponse.toEntity().musclesGroup,
              ),
            ],
      );

      blocTest(
        'emits loading → error state when use case returns error ',
        build: () => cubit,
        setUp: () {
          getMusclesGroupError = Exception('error');
          provideDummy<ApiResult<List<MuscleGroupEntity>?>>(
            Error<List<MuscleGroupEntity>?>(error: getMusclesGroupError),
          );
          when(getMusclesGroupUseCase.execute()).thenAnswer(
            (_) async =>
                Error<List<MuscleGroupEntity>?>(error: getMusclesGroupError),
          );
        },
        act: (cubit) => cubit.doIntent(GetMusclesGroupIntent()),
        expect:
            () => [
              const WorkoutsPageState(
                getMusclesGroupStatus: WorkoutsPageStatus.loading,
              ),
              WorkoutsPageState(
                getMusclesGroupStatus: WorkoutsPageStatus.error,
                getMusclesGroupError: getMusclesGroupError,
              ),
            ],
      );
    });

    group(' get muscle group workouts', () {
      blocTest(
        'emits loading → success state when use case returns success ',
        build: () => cubit,
        setUp: () {
          getMuscleGroupWorkoutsResponse = MuscleGroupWorkoutsResponse(
            message: 'success',
            muscleGroup: MuscleGroup(id: '1', name: 'name'),
            muscles: [Muscle(id: '1', name: 'name', image: 'image')],
          );
          provideDummy<ApiResult<List<MuscleEntity>?>>(
            Success<List<MuscleEntity>?>(
              data: getMuscleGroupWorkoutsResponse.toEntity().musclesEntity,
            ),
          );
          when(getMuscleGroupWorkoutUseCase.execute(any)).thenAnswer(
            (_) async => Success<List<MuscleEntity>?>(
              data: getMuscleGroupWorkoutsResponse.toEntity().musclesEntity,
            ),
          );
        },
        act: (cubit) => cubit.doIntent(GetMuscleGroupWorkoutsIntent(id: '1')),
        expect:
            () => [
              const WorkoutsPageState(
                getMuscleGroupWorkoutsStatus: WorkoutsPageStatus.loading,
              ),
              WorkoutsPageState(
                getMuscleGroupWorkoutsStatus: WorkoutsPageStatus.success,
                muscleGroupWorkouts:
                    getMuscleGroupWorkoutsResponse.toEntity().musclesEntity,
              ),
            ],
      );

      blocTest(
        'emits loading → error state when use case returns error ',
        build: () => cubit,
        setUp: () {
          getMuscleGroupWorkoutsError = Exception('error');
          provideDummy<ApiResult<List<MuscleEntity>?>>(
            Error<List<MuscleEntity>?>(error: getMuscleGroupWorkoutsError),
          );
          when(getMuscleGroupWorkoutUseCase.execute(any)).thenAnswer(
            (_) async =>
                Error<List<MuscleEntity>?>(error: getMuscleGroupWorkoutsError),
          );
        },
        act: (cubit) => cubit.doIntent(GetMuscleGroupWorkoutsIntent(id: '1')),
        expect:
            () => [
              const WorkoutsPageState(
                getMuscleGroupWorkoutsStatus: WorkoutsPageStatus.loading,
              ),
              WorkoutsPageState(
                getMuscleGroupWorkoutsStatus: WorkoutsPageStatus.error,
                getMuscleGroupWorkoutsError: getMuscleGroupWorkoutsError,
              ),
            ],
      );
    });
  });
}
