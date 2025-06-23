import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:super_fitness/modules/authentication/data/models/login/login.dart';
import 'package:super_fitness/modules/authentication/data/models/register/response/register_response_dto.dart';

import '../../../../../core/apis/apis_endpoints/apis_endpoints.dart';

part 'auth_api_client.g.dart';

@RestApi(baseUrl: ApisEndpoints.baseUrl)
abstract class AuthApiClient {
  factory AuthApiClient(Dio dio) = _AuthApiClient;

  @POST(ApisEndpoints.registerEndPoint)
  Future<RegisterResponseDto> register(@Body() Map<String, dynamic> request);
  @POST(ApisEndpoints.loginEndPoint)
  Future<LoginModel> login(@Body() Map<String, dynamic> body);
}
