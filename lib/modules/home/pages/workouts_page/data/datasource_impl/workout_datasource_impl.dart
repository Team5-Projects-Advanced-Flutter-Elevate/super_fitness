import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/modules/home/pages/workouts_page/data/api/api_client/workout_page_api_client.dart';
import 'package:super_fitness/modules/home/pages/workouts_page/domain/entities/muscle_group_workout_response_entity.dart';

import 'package:super_fitness/modules/home/pages/workouts_page/domain/entities/muscles_group_response_entity.dart';

import '../../../../../../core/apis/api_executor/api_executor.dart';
import '../datasource_contract/workout_datasource_contract.dart';
import '../models/get_all_muscles_group_response.dart';
import '../models/muscle_group_workouts.dart';

@Injectable(as: WorkoutDatasource)
class WorkoutDatasourceImpl implements WorkoutDatasource {
  WorkoutApiClient workoutApiClient;

  WorkoutDatasourceImpl(this.workoutApiClient);

  @override
  Future<ApiResult<List<MuscleGroupEntity>?>> getMusclesGroup() async {
    var result = await ApiExecutor.executeApi(
      () => workoutApiClient.getMusclesGroup(),
    );
    switch (result) {
      case Success<GetMusclesGroupResponse>():
        return Success(data: result.data.toEntity().musclesGroup);
      case Error<GetMusclesGroupResponse>():
        return Error(error: result);
    }
  }

  @override
  Future<ApiResult<List<MuscleEntity>?>> getMuscleGroupWorkouts(
    String id,
  ) async {
    var result = await ApiExecutor.executeApi(
      () => workoutApiClient.getMusclesGroupWorkouts(id),
    );
    switch (result) {
      case Success<MuscleGroupWorkoutsResponse>():
        return Success(data: result.data.toEntity().musclesEntity);
      case Error<MuscleGroupWorkoutsResponse>():
        return Error(error: result);
    }
  }
}
