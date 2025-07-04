import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart' as http;
import 'package:retrofit/retrofit.dart';
import 'package:super_fitness/modules/food/data/models/get_food_categories_model.dart';
import 'package:super_fitness/modules/food/data/models/meal_by_category_model.dart';

import '../../../../../core/apis/apis_endpoints/apis_endpoints.dart';

part 'food_api_client.g.dart';

@RestApi(baseUrl: ApisEndpoints.foodBaseUrl)
abstract class FoodApiClient {
  factory FoodApiClient(
    Dio dio, {
    String? baseUrl,
    http.ParseErrorLogger? errorLogger,
  }) = _FoodApiClient;

  @GET(ApisEndpoints.getFoodCategories)
  Future<GetFoodCategoriesModel> getFoodCategories();
  @GET(ApisEndpoints.getFoodByCategory)
  Future<MealByCategoryModel> getMealByCategoryName(
    @Query('c') String categoryName,
  );
}
