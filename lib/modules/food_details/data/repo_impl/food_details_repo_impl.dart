import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/modules/food_details/data/datasource_contract/food_details_datasource.dart';

import 'package:super_fitness/modules/food_details/domain/entities/food_details_entity.dart';

import '../../domain/repo_contract/food_details_repo_contract.dart';

@Injectable(as: FoodDetailsRepo)
class FoodDetailsRepoImpl implements FoodDetailsRepo {
  FoodDetailsDataSource foodDetailsDataSource;

  FoodDetailsRepoImpl(this.foodDetailsDataSource);

  @override
  Future<ApiResult<FoodDetailsEntity>> getFoodDetails(String id) {
    return foodDetailsDataSource.getFoodDetails(id);
  }
}
