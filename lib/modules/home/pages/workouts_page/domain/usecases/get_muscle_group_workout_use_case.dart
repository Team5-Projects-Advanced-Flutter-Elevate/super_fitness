import 'package:injectable/injectable.dart';
import 'package:super_fitness/modules/home/pages/workouts_page/domain/repo_contract/workout_repo_contract.dart';

import '../../../../../../core/apis/api_result/api_result.dart';
import '../entities/muscle_group_workout_response_entity.dart';

@injectable
class GetMuscleGroupWorkoutUseCase {
  final WorkoutRepo workoutRepo;

  GetMuscleGroupWorkoutUseCase(this.workoutRepo);

  Future<ApiResult<List<MuscleEntity>?>> execute(String id) =>
      workoutRepo.getMuscleGroupWorkouts(id);
}
