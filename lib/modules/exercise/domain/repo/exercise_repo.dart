import 'package:super_fitness/core/apis/api_result/api_result.dart';

import '../entity/exercise_entity.dart';

abstract interface class ExerciseRepo {
  Future<ApiResult<GetExerciseEntity>> getExerciseList(String muscleId, String levelId);
}
