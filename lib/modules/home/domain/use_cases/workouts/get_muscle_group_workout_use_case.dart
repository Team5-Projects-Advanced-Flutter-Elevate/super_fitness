import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/modules/home/domain/repositories_contracts/workout_repo_contract.dart';

import '../../entities/workouts/muscle_group_workout_response_entity.dart';

@injectable
class GetMuscleGroupWorkoutUseCase {
  final WorkoutRepo workoutRepo;

  GetMuscleGroupWorkoutUseCase(this.workoutRepo);

  Future<ApiResult<List<MuscleEntity>?>> execute(String id) =>
      workoutRepo.getMuscleGroupWorkouts(id);
}
