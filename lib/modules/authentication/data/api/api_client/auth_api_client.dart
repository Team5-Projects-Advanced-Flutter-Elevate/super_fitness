import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../../core/apis/apis_endpoints/apis_endpoints.dart';
import '../../models/forget_password/forget_password_response.dart';

part 'auth_api_client.g.dart';

@RestApi(baseUrl: ApisEndpoints.baseUrl)
abstract class AuthApiClient {
  factory AuthApiClient(Dio dio) = _AuthApiClient;

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
}
