import '../../../../core/apis/api_result/api_result.dart';
import '../../domain/entity/exercise_entity.dart';

abstract interface class ExerciseOnlineDataSource {
  Future<ApiResult<GetExerciseEntity>> getExerciseList(
    String muscleId,
    String levelId,
  );
}
