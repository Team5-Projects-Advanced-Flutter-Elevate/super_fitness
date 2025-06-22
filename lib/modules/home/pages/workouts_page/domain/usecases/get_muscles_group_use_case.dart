import 'package:injectable/injectable.dart';
import 'package:super_fitness/modules/home/pages/workouts_page/domain/repo_contract/workout_repo_contract.dart';

import '../../../../../../core/apis/api_result/api_result.dart';
import '../entities/muscles_group_response_entity.dart';

@injectable
class GetMusclesGroupUseCase {
  WorkoutRepo workoutRepo;

  GetMusclesGroupUseCase(this.workoutRepo);

  Future<ApiResult<List<MuscleGroupEntity>?>> execute() =>
      workoutRepo.getMusclesGroup();
}
