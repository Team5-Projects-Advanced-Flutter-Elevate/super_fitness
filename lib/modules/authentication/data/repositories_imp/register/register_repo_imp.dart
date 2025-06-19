import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/modules/authentication/data/data_sources_contracts/register/register_remote_data_source.dart';
import 'package:super_fitness/modules/authentication/domain/entities/register/request/register_request_entity.dart';
import 'package:super_fitness/modules/authentication/domain/entities/register/response/register_response_entity.dart';
import 'package:super_fitness/modules/authentication/domain/repositories_contracts/register/register_repo.dart';

@Injectable(as: RegisterRepo)
class RegisterRepoImp implements RegisterRepo {
  final RegisterRemoteDataSource _registerRemoteDataSource;

  RegisterRepoImp(this._registerRemoteDataSource);

  @override
  Future<ApiResult<RegisterResponseEntity>> register({
    required RegisterRequestEntity registerRequestEntity,
  }) {
    return _registerRemoteDataSource.register(
      registerRequestEntity: registerRequestEntity,
    );
  }
}
