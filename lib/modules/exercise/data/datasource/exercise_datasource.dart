import '../../../../core/apis/api_result/api_result.dart';
import '../../domain/entity/exercise_entity.dart';
import '../../domain/entity/get_exercise.dart';

abstract class ExerciseOnlineDataSource {
  Future<ApiResult<GetExerciseEntity>> exercise(String muscleId, String levelId);
}
