import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../api_client/food_details_api_client.dart';

@module
abstract class FoodDetailsApiClientProvider {
  @lazySingleton
  FoodDetailsApiClient provideApiClient(Dio dio) {
    return FoodDetailsApiClient(dio);
  }
}
