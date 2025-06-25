import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/modules/food/domain/entities/food_categories_entity.dart';
import 'package:super_fitness/modules/food/domain/entities/meal_entity.dart';
import 'package:super_fitness/modules/food/domain/repositories_contracts/food_repo_contract.dart';

import '../data_sources_contracts/food_data_source_contract.dart';

@Injectable(as: FoodRepoContract)
class FoodRepoImp implements FoodRepoContract {
  final FoodDataSourceContract _foodDataSourceContract;

  FoodRepoImp(this._foodDataSourceContract);
  @override
  Future<ApiResult<List<MealEntity>>> getFoodByCategory(
    String categoryName,
  ) async {
    return await _foodDataSourceContract.getFoodByCategory(categoryName);
  }

  @override
  Future<ApiResult<List<FoodCategoryEntity>>> getFoodCategories() {
    return _foodDataSourceContract.getFoodCategories();
  }
}
