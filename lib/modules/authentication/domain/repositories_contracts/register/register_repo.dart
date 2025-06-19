import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/modules/authentication/domain/entities/register/request/register_request_entity.dart';
import 'package:super_fitness/modules/authentication/domain/entities/register/response/register_response_entity.dart';

abstract interface class RegisterRepo {
  Future<ApiResult<RegisterResponseEntity>> register({
    required RegisterRequestEntity registerRequestEntity,
  });
}
