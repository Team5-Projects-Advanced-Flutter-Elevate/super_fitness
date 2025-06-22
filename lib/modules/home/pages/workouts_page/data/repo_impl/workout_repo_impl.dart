import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/modules/home/pages/workouts_page/data/datasource_contract/workout_datasource_contract.dart';
import 'package:super_fitness/modules/home/pages/workouts_page/domain/entities/muscle_group_workout_response_entity.dart';

import 'package:super_fitness/modules/home/pages/workouts_page/domain/entities/muscles_group_response_entity.dart';

import '../../domain/repo_contract/workout_repo_contract.dart';

@Injectable(as: WorkoutRepo)
class WorkoutRepoImpl implements WorkoutRepo {
  WorkoutDatasource workoutDatasource;

  WorkoutRepoImpl({required this.workoutDatasource});

  @override
  Future<ApiResult<List<MuscleGroupEntity>?>> getMusclesGroup() {
    return workoutDatasource.getMusclesGroup();
  }

  @override
  Future<ApiResult<List<MuscleEntity>?>> getMuscleGroupWorkouts(String id) {
    return workoutDatasource.getMuscleGroupWorkouts(id);
  }
}
