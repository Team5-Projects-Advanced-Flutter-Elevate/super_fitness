import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/modules/home/domain/entities/random_exercises/random_exercises_request_entity.dart';
import 'package:super_fitness/modules/home/domain/entities/random_exercises/random_exercises_response_entity.dart';

abstract interface class RandomExercisesRemoteDataSource {
  Future<ApiResult<RandomExercisesResponseEntity>> getRandomExercises({
    required RandomExercisesRequestEntity exercisesRequestEntity,
  });
}
