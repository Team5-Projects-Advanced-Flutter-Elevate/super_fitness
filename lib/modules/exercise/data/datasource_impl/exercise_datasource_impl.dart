import 'package:injectable/injectable.dart';
import 'package:super_fitness/modules/exercise/data/model/get_exercise.dart';

import '../../../../core/apis/api_executor/api_executor.dart';
import '../../../../core/apis/api_result/api_result.dart';
import '../../domain/entity/exercise_entity.dart';
import '../../domain/entity/get_exercise.dart';
import '../api/api_client/exercise_api_client.dart';
import '../datasource/exercise_datasource.dart';

@Injectable(as: ExerciseOnlineDataSource)
class ExerciseOnlineDataSourceImpl implements ExerciseOnlineDataSource {
  final ExerciseApiClient _apiClient;
  ExerciseOnlineDataSourceImpl(this._apiClient);
  @override
  Future<ApiResult<GetExerciseEntity>> exercise(
    String muscleId,
    String levelId,
  ) async {
    var apiResult = await ApiExecutor.executeApi(
      () => _apiClient.exercise(muscleId: muscleId, levelId: levelId),
    );
    switch (apiResult) {
      case Success<GetExerciseModel>():
        print('lllll${apiResult.data.exercises.length}');
        return Success(data: apiResult.data.toEntity());
      case Error<GetExerciseModel>():
        return Error(error: apiResult.error);
    }
  }
}
