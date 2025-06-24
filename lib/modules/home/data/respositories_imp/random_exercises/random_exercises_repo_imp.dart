import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/modules/home/data/data_sources_contracts/random_exercises/random_exercises_remote_data_source.dart';
import 'package:super_fitness/modules/home/domain/entities/random_exercises/random_exercises_request_entity.dart';
import 'package:super_fitness/modules/home/domain/entities/random_exercises/random_exercises_response_entity.dart';
import 'package:super_fitness/modules/home/domain/repositories_contracts/random_exercises/random_exercise_repo.dart';

@Injectable(as: RandomExercisesRepo)
class RandomExercisesRepoImp implements RandomExercisesRepo {
  final RandomExerciseRemoteDataSource _randomExerciseRemoteDataSource;

  RandomExercisesRepoImp(this._randomExerciseRemoteDataSource);

  @override
  Future<ApiResult<RandomExercisesResponseEntity>> getRandomExercises({
    required RandomExercisesRequestEntity exercisesRequestEntity,
  }) {
    return _randomExerciseRemoteDataSource.getRandomExercises(
      exercisesRequestEntity: exercisesRequestEntity,
    );
  }
}
