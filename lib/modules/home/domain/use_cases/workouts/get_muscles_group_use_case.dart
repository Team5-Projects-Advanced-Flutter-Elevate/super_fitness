import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/modules/home/domain/entities/workouts/muscles_group_response_entity.dart';
import 'package:super_fitness/modules/home/domain/repositories_contracts/workout_repo_contract.dart';

@injectable
class GetMusclesGroupUseCase {
  WorkoutRepo workoutRepo;

  GetMusclesGroupUseCase(this.workoutRepo);

  Future<ApiResult<List<MuscleGroupEntity>?>> execute() =>
      workoutRepo.getMusclesGroup();
}
