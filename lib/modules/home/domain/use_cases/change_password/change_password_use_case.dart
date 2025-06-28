import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/modules/home/domain/entities/change_password/change_password_response_entity.dart';
import 'package:super_fitness/modules/home/domain/repositories_contracts/change_password_repo_contract.dart';

@injectable
class ChangePasswordUseCase {
  ChangePasswordRepoContract changePasswordRepoContract;
  @factoryMethod
  ChangePasswordUseCase(this.changePasswordRepoContract);
  Future<ApiResult<ChangePasswordResponseEntity>> call(
    String password,
    String newPassword,
  ) => changePasswordRepoContract.changePassword(password, newPassword);
}
