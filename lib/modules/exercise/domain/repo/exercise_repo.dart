import 'package:super_fitness/core/apis/api_result/api_result.dart';

import '../entity/exercise_entity.dart';

abstract class ExerciseRepo {
  Future<ApiResult<GetExerciseEntity>> exercise(String muscleId, String levelId);
}
