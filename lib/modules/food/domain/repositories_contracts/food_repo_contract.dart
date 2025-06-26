import '../../../../core/apis/api_result/api_result.dart';
import '../entities/food_categories_entity.dart';
import '../entities/meal_entity.dart';

abstract interface class FoodRepoContract {
  Future<ApiResult<List<FoodCategoryEntity>>> getFoodCategories();
  Future<ApiResult<List<MealEntity>>> getFoodByCategory(String categoryName);
}
