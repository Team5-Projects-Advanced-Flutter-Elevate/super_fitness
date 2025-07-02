import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:super_fitness/core/apis/apis_endpoints/apis_endpoints.dart';
import 'package:super_fitness/modules/home/data/models/change_password/change_password_response_dto.dart';

import '../../models/profile_response.dart';

part 'profile_api_client.g.dart';

@RestApi()
abstract class ProfileApiClient {
  factory ProfileApiClient(Dio dio) = _ProfileApiClient;

  @GET(ApisEndpoints.getProfileData)
  Future<ProfileResponse> getProfile();
  @PATCH(ApisEndpoints.changePasswordEndPoint)
  Future<ChangePasswordResponseDto> changePassword(
    @Body() Map<String, dynamic> body,
    @Header("Accept-Language") String languageCode,
  );
}
