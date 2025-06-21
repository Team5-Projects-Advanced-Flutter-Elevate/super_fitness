import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import '../../../../../core/apis/apis_endpoints/apis_endpoints.dart';
import '../../models/food_details.dart';

part 'food_details_api_client.g.dart';

@RestApi(baseUrl: ApisEndpoints.foodBaseURL)
abstract class FoodDetailsApiClient {
  factory FoodDetailsApiClient(Dio dio) = _FoodDetailsApiClient;

  @GET(ApisEndpoints.foodDetails)
  Future<FoodDetailsModel> getFoodDetails(@Query("i") String id);
}
