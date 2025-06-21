import 'dart:developer';

import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/apis/api_executor/api_executor.dart';
import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/modules/food_details/data/api/api_client/food_details_api_client.dart';
import 'package:super_fitness/modules/food_details/data/models/food_details.dart';

import 'package:super_fitness/modules/food_details/domain/entities/food_details_entity.dart';

import '../datasource_contract/food_details_datasource.dart';

@Injectable(as: FoodDetailsDataSource)
class FoodDetailsDataSourceImpl implements FoodDetailsDataSource {
  FoodDetailsApiClient foodDetailsApiClient;

  FoodDetailsDataSourceImpl(this.foodDetailsApiClient);

  @override
  Future<ApiResult<FoodDetailsEntity>> getFoodDetails(String id) async {
    var result = await ApiExecutor.executeApi(
      () => foodDetailsApiClient.getFoodDetails(id),
    );
    switch (result) {
      case Success<FoodDetailsModel>():
        log(result.data.toString());
        return Success(data: result.data.toEntity());
      case Error<FoodDetailsModel>():
        log(result.error.toString());
        return Error(error: result);
    }
  }
}
