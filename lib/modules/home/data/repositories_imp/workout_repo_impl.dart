import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/modules/home/data/data_sources_contracts/workout_datasource_contract.dart';
import 'package:super_fitness/modules/home/domain/entities/workouts/muscle_group_workout_response_entity.dart';
import 'package:super_fitness/modules/home/domain/entities/workouts/muscles_group_response_entity.dart';
import 'package:super_fitness/modules/home/domain/repositories_contracts/workout_repo_contract.dart';

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
