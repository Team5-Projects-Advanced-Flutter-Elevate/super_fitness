import 'package:injectable/injectable.dart';
import 'package:super_fitness/modules/food_details/domain/repo_contract/food_details_repo_contract.dart';

import '../../../../core/apis/api_result/api_result.dart';
import '../entities/food_details_entity.dart';

@injectable
class GetFoodDetailsUseCase {
  final FoodDetailsRepo foodDetailsRepo;

  GetFoodDetailsUseCase(this.foodDetailsRepo);

  Future<ApiResult<FoodDetailsEntity>> execute(String id) =>
      foodDetailsRepo.getFoodDetails(id);
}
