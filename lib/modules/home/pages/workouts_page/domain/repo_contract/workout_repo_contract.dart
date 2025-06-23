import '../../../../../../core/apis/api_result/api_result.dart';
import '../entities/muscle_group_workout_response_entity.dart';
import '../entities/muscles_group_response_entity.dart';

abstract interface class WorkoutRepo {
  Future<ApiResult<List<MuscleGroupEntity>?>> getMusclesGroup();

  Future<ApiResult<List<MuscleEntity>?>> getMuscleGroupWorkouts(String id);
}
