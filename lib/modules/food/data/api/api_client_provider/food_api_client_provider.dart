import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/apis/apis_endpoints/apis_endpoints.dart';
import '../api_client/food_api_client.dart';

@module
abstract class FoodApiClientProvider {
  @lazySingleton
  FoodApiClient provideApiClient(Dio dio) {
    return FoodApiClient(dio, baseUrl: ApisEndpoints.foodBaseUrl);
  }
}
