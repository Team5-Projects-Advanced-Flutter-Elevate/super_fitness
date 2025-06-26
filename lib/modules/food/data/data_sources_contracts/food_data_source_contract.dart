import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/modules/food/domain/entities/food_categories_entity.dart';
import 'package:super_fitness/modules/food/domain/entities/meal_entity.dart';

abstract interface class FoodDataSourceContract {
  Future<ApiResult<List<FoodCategoryEntity>>> getFoodCategories();
  Future<ApiResult<List<MealEntity>>> getFoodByCategory(String categoryName);
}
