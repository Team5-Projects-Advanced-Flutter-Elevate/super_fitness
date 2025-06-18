import 'package:injectable/injectable.dart';

import '../../../../../core/apis/api_result/api_result.dart';
import '../../../domain/repositories_contracts/forget_password/reset_password_repo.dart';
import '../../data_sources_contracts/forget_password/reset_password_remote_data_source.dart';
import '../../models/forget_password/forget_password_response.dart';

@Injectable(as: ResetPasswordRepo)
class ResetPasswordRepoImpl extends ResetPasswordRepo {
  ResetPasswordRemoteDataSource apiDataSource;
  @factoryMethod
  ResetPasswordRepoImpl(this.apiDataSource);
  @override
  Future<ApiResult<ForgetPasswordResponse?>> resetPassword(
    String email,
    String newPassword,
  ) async {
    var result = await apiDataSource.resetPassword(email, newPassword);
    switch (result) {
      case Success<ForgetPasswordResponse?>():
        return Success(data: result.data);
      case Error<ForgetPasswordResponse?>():
        return Error(error: result.error);
    }
  }
}
