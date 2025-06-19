import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/apis/api_executor/api_executor.dart';
import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/modules/authentication/data/api/api_client/auth_api_client.dart';
import 'package:super_fitness/modules/authentication/data/data_sources_contracts/register/register_remote_data_source.dart';
import 'package:super_fitness/modules/authentication/data/models/register/request/register_request_dto.dart';
import 'package:super_fitness/modules/authentication/data/models/register/response/register_response_dto.dart';
import 'package:super_fitness/modules/authentication/domain/entities/register/request/register_request_entity.dart';
import 'package:super_fitness/modules/authentication/domain/entities/register/response/register_response_entity.dart';

@Injectable(as: RegisterRemoteDataSource)
class RegisterRemoteDataSourceImp implements RegisterRemoteDataSource {
  final AuthApiClient _authApiClient;

  RegisterRemoteDataSourceImp(this._authApiClient);

  @override
  Future<ApiResult<RegisterResponseEntity>> register({
    required RegisterRequestEntity registerRequestEntity,
  }) async {
    var apiResult = await ApiExecutor.executeApi(
      () => _authApiClient.register(
        RegisterRequestDto.convertIntDto(registerRequestEntity).toJson(),
      ),
    );
    switch (apiResult) {
      case Success<RegisterResponseDto>():
        return Success(data: apiResult.data.convertIntoEntity());
      case Error<RegisterResponseDto>():
        return Error(error: apiResult.error);
    }
  }
}
