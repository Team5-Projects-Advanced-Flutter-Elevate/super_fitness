import 'package:super_fitness/modules/home/domain/entities/workouts/muscle_group_workout_response_entity.dart';
import 'package:super_fitness/modules/home/domain/entities/workouts/muscles_group_response_entity.dart';

import '../../../../../../core/apis/api_result/api_result.dart';

abstract interface class WorkoutRepo {
  Future<ApiResult<List<MuscleGroupEntity>?>> getMusclesGroup();

  Future<ApiResult<List<MuscleEntity>?>> getMuscleGroupWorkouts(String id);
}
