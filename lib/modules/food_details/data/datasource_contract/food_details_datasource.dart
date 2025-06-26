import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/modules/food_details/domain/entities/food_details_entity.dart';

abstract interface class FoodDetailsDataSource {
  Future<ApiResult<FoodDetailsEntity>> getFoodDetails(String id);
}
