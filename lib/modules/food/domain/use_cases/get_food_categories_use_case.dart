import 'package:injectable/injectable.dart';
import 'package:super_fitness/modules/food/domain/repositories_contracts/food_repo_contract.dart';

import '../../../../core/apis/api_result/api_result.dart';
import '../entities/food_categories_entity.dart';

@injectable
class GetFoodCategoriesUseCase {
  final FoodRepoContract _foodRepoContract;

  GetFoodCategoriesUseCase(this._foodRepoContract);

  Future<ApiResult<List<FoodCategoryEntity>>> call() {
    return _foodRepoContract.getFoodCategories();
  }
}
