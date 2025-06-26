import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/modules/food/data/api/api_client/food_api_client.dart';
import 'package:super_fitness/modules/food/data/data_sources_contracts/food_data_source_contract.dart';
import 'package:super_fitness/modules/food/data/models/get_food_categories_model.dart';
import 'package:super_fitness/modules/food/data/models/meal_by_category_model.dart';
import 'package:super_fitness/modules/food/domain/entities/food_categories_entity.dart';
import 'package:super_fitness/modules/food/domain/entities/meal_entity.dart';

import '../../../../core/apis/api_executor/api_executor.dart';

@Injectable(as: FoodDataSourceContract)
class FoodDataSourceImp implements FoodDataSourceContract {
  final FoodApiClient _foodApiClient;

  FoodDataSourceImp(this._foodApiClient);
  @override
  Future<ApiResult<List<MealEntity>>> getFoodByCategory(
    String categoryName,
  ) async {
    var apiResult = await ApiExecutor.executeApi(
      () => _foodApiClient.getMealByCategoryName(categoryName),
    );
    switch (apiResult) {
      case Success<MealByCategoryModel>():
        return Success(data: apiResult.data.toEntity());
      case Error<MealByCategoryModel>():
        return Error(error: apiResult.error);
    }
  }

  @override
  Future<ApiResult<List<FoodCategoryEntity>>> getFoodCategories() async {
    var apiResult = await ApiExecutor.executeApi(
      () => _foodApiClient.getFoodCategories(),
    );
    switch (apiResult) {
      case Success<GetFoodCategoriesModel>():
        return Success(data: apiResult.data.toEntity());
      case Error<GetFoodCategoriesModel>():
        return Error(error: apiResult.error);
    }
  }
}
