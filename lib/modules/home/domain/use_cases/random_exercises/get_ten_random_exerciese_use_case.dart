import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/modules/home/domain/entities/random_exercises/random_exercises_request_entity.dart';
import 'package:super_fitness/modules/home/domain/entities/random_exercises/random_exercises_response_entity.dart';
import 'package:super_fitness/modules/home/domain/repositories_contracts/random_exercises/random_exercise_repo.dart';

@injectable
class GetTenRandomExerciseUseCase {
  final RandomExercisesRepo _randomExercisesRepo;

  GetTenRandomExerciseUseCase(this._randomExercisesRepo);

  Future<ApiResult<RandomExercisesResponseEntity>> call() {
    return _randomExercisesRepo.getRandomExercises(
      exercisesRequestEntity: const RandomExercisesRequestEntity(
        limit: 10,
        targetMuscleGroupId: "67c79f3526895f87ce0aa96d",
        difficultyLevelId: "67c797e226895f87ce0aa94b",
      ),
    );
  }
}
