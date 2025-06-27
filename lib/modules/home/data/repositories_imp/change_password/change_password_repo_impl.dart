import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/modules/home/data/data_sources_contracts/change_password/change_password_remote_data_source_contract.dart';
import 'package:super_fitness/modules/home/domain/entities/change_password/change_password_response_entity.dart';
import 'package:super_fitness/modules/home/domain/repositories_contracts/change_password_repo_contract.dart';

@Injectable(as: ChangePasswordRepoContract)
class ChangePasswordRepoImpl implements ChangePasswordRepoContract {
  final ChangePasswordRemoteDataSourceContract changePasswordRemoteDataSourceContract;

  ChangePasswordRepoImpl(this.changePasswordRemoteDataSourceContract);

  @override
  Future<ApiResult<ChangePasswordResponseEntity>> changePassword(
    String password,
    String newPassword,
  ) {
    return changePasswordRemoteDataSourceContract.changePassword(
      password,
      newPassword,
    );
  }
}