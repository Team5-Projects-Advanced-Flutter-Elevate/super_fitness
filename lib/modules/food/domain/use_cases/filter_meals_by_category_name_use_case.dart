import 'package:injectable/injectable.dart';
import 'package:super_fitness/modules/food/domain/entities/meal_entity.dart';
import 'package:super_fitness/modules/food/domain/repositories_contracts/food_repo_contract.dart';

import '../../../../core/apis/api_result/api_result.dart';

@injectable
class FilterMealsByCategoryNameUseCase {
  final FoodRepoContract _foodRepoContract;

  FilterMealsByCategoryNameUseCase(this._foodRepoContract);

  Future<ApiResult<List<MealEntity>>> call(String categoryName) {
    return _foodRepoContract.getFoodByCategory(categoryName);
  }
}
