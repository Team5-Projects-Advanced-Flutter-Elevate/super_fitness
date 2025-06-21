import 'package:injectable/injectable.dart';
import 'package:super_fitness/modules/exercise/data/datasource/exercise_datasource.dart';

import '../../../../core/apis/api_result/api_result.dart';
import '../../domain/entity/exercise_entity.dart';
import '../../domain/repo/exercise_repo.dart';

@Injectable(as: ExerciseRepo)
class ExerciseRepoImpl implements ExerciseRepo {
  final ExerciseOnlineDataSource _exerciseOnlineDataSource;

  ExerciseRepoImpl(this._exerciseOnlineDataSource);

  @override
  Future<ApiResult<GetExerciseEntity>> exercise(String muscleId, String levelId) {
    return _exerciseOnlineDataSource.exercise(muscleId, levelId);
  }
}
