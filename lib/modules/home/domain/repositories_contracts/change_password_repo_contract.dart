import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/modules/home/domain/entities/change_password/change_password_response_entity.dart';

abstract class ChangePasswordRepoContract {
  Future<ApiResult<ChangePasswordResponseEntity>> changePassword(
    String password,
    String newPassword,
    );
}