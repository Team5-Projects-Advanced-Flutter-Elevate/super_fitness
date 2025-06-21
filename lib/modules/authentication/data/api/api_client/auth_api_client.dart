import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart' as http;
import 'package:retrofit/retrofit.dart';
import 'package:super_fitness/modules/authentication/data/models/login/login.dart';
import 'package:super_fitness/modules/authentication/data/models/register/response/register_response_dto.dart';

import '../../../../../core/apis/apis_endpoints/apis_endpoints.dart';
import '../../models/forget_password/forget_password_response.dart';

part 'auth_api_client.g.dart';

@RestApi(baseUrl: ApisEndpoints.baseUrl)
abstract class AuthApiClient {
  //factory AuthApiClient(Dio dio, {String? baseUrl}) = _AuthApiClient;
  factory AuthApiClient(
    Dio dio, {
    String? baseUrl,
    http.ParseErrorLogger? errorLogger,
  }) = _AuthApiClient;
  @POST(ApisEndpoints.forgetPasswordEndPoint)
  Future<ForgetPasswordResponse?> forgetPassword(
    @Body() Map<String, dynamic> body,
  );

  @PUT(ApisEndpoints.resetPasswordEndPoint)
  Future<ForgetPasswordResponse?> resetPassword(
    @Body() Map<String, dynamic> body,
  );

  @POST(ApisEndpoints.resetCodeEndPoint)
  Future<ForgetPasswordResponse?> resetCode(@Body() Map<String, dynamic> body);
  @POST(ApisEndpoints.registerEndPoint)
  Future<RegisterResponseDto> register(@Body() Map<String, dynamic> request);
  @POST(ApisEndpoints.loginEndPoint)
  Future<LoginModel> login(@Body() Map<String, dynamic> body);
}
