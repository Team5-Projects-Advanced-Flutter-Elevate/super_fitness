import 'package:injectable/injectable.dart';

import '../../../../../core/apis/api_result/api_result.dart';
import '../../../domain/repositories_contracts/forget_password/forget_password_repo.dart';
import '../../data_sources_contracts/forget_password/forget_password_remote_data_source.dart';
import '../../models/forget_password/forget_password_response.dart';

@Injectable(as: ForgetPasswordRepo)
class ForgetPasswordRepoImpl extends ForgetPasswordRepo {
  ForgetPasswordRemoteDataSource apiDataSource;
  @factoryMethod
  ForgetPasswordRepoImpl(this.apiDataSource);
  @override
  Future<ApiResult<ForgetPasswordResponse?>> forgetPassword(
    String email,
  ) async {
    var result = await apiDataSource.forgetPassword(email);
    return result;
  }

  @override
  Future<ApiResult<ForgetPasswordResponse?>> resetPassword(
    String email,
    String newPassword,
  ) async {
    var result = await apiDataSource.resetPassword(email, newPassword);
    return result;
  }

  @override
  Future<ApiResult<ForgetPasswordResponse?>> resetCode(String code) async {
    var result = await apiDataSource.resetCode(code);
    return result;
  }
}
