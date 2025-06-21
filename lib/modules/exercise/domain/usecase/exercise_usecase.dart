import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/modules/exercise/domain/repo/exercise_repo.dart';

import '../entity/exercise_entity.dart';

@injectable
class ExerciseUseCase {
  final ExerciseRepo _exerciseRepo;

  ExerciseUseCase(this._exerciseRepo);
  Future<ApiResult<GetExerciseEntity>> call(String muscleId, String levelId) {
    return _exerciseRepo.exercise(muscleId, levelId);
  }
}
