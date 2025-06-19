import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/modules/authentication/domain/entities/register/request/register_request_entity.dart';
import 'package:super_fitness/modules/authentication/domain/entities/register/response/register_response_entity.dart';
import 'package:super_fitness/modules/authentication/domain/repositories_contracts/register/register_repo.dart';

@injectable
class RegisterUserCase {
  final RegisterRepo _registerRepo;

  RegisterUserCase(this._registerRepo);

  Future<ApiResult<RegisterResponseEntity>> call({
    required RegisterRequestEntity registerRequestEntity,
  }) {
    return _registerRepo.register(registerRequestEntity: registerRequestEntity);
  }
}
