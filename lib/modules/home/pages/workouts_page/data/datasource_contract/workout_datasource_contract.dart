import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/modules/home/pages/workouts_page/domain/entities/muscle_group_workout_response_entity.dart';
import 'package:super_fitness/modules/home/pages/workouts_page/domain/entities/muscles_group_response_entity.dart';

abstract interface class WorkoutDatasource {
  Future<ApiResult<List<MuscleGroupEntity>?>> getMusclesGroup();

  Future<ApiResult<List<MuscleEntity>?>> getMuscleGroupWorkouts(String id);
}
