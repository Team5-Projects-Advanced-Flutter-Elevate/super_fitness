import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/apis/api_executor/api_executor.dart';
import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/modules/home/data/api/api_client/home_api_client.dart';
import 'package:super_fitness/modules/home/domain/entities/workouts/muscle_group_workout_response_entity.dart';
import 'package:super_fitness/modules/home/domain/entities/workouts/muscles_group_response_entity.dart';

import '../data_sources_contracts/workout_datasource_contract.dart';
import '../models/workouts/get_all_muscles_group_response.dart';
import '../models/workouts/muscle_group_workouts.dart';

@Injectable(as: WorkoutDatasource)
class WorkoutDatasourceImpl implements WorkoutDatasource {
  HomeApiClient homeApiClient;

  WorkoutDatasourceImpl(this.homeApiClient);

  @override
  Future<ApiResult<List<MuscleGroupEntity>?>> getMusclesGroup() async {
    var result = await ApiExecutor.executeApi(
      () => homeApiClient.getMusclesGroup(),
    );
    switch (result) {
      case Success<GetMusclesGroupResponse>():
        return Success(data: result.data.toEntity().musclesGroup);
      case Error<GetMusclesGroupResponse>():
        return Error(error: result.error);
    }
  }

  @override
  Future<ApiResult<List<MuscleEntity>?>> getMuscleGroupWorkouts(
    String id,
  ) async {
    var result = await ApiExecutor.executeApi(
      () => homeApiClient.getMusclesGroupWorkouts(id),
    );
    switch (result) {
      case Success<MuscleGroupWorkoutsResponse>():
        return Success(data: result.data.toEntity().musclesEntity);
      case Error<MuscleGroupWorkoutsResponse>():
        return Error(error: result);
    }
  }
}
