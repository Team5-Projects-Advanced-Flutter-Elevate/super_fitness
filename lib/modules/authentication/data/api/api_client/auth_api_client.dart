import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:super_fitness/core/apis/apis_endpoints/apis_endpoints.dart';
import 'package:super_fitness/modules/authentication/data/models/register/response/register_response_dto.dart';

part 'auth_api_client.g.dart';

@RestApi()
abstract class AuthApiClient {
  factory AuthApiClient(Dio dio) = _AuthApiClient;

  @POST(ApisEndpoints.registerEndPoint)
  Future<RegisterResponseDto> register(@Body() Map<String, dynamic> request);
}
