import 'package:injectable/injectable.dart';

import '../../../../../core/apis/api_result/api_result.dart';
import '../../../domain/repositories_contracts/forget_password/reset_code_repo.dart';
import '../../data_sources_contracts/forget_password/reset_code_remote_data_source.dart';
import '../../models/forget_password/forget_password_response.dart';

@Injectable(as: ResetCodeRepo)
class ResetCodeRepoImpl extends ResetCodeRepo {
  ResetCodeRemoteDataSource apiDataSource;
  @factoryMethod
  ResetCodeRepoImpl(this.apiDataSource);
  @override
  Future<ApiResult<ForgetPasswordResponse?>> resetCode(String code) async {
    var result = await apiDataSource.resetCode(code);
    switch (result) {
      case Success<ForgetPasswordResponse?>():
        return Success(data: result.data);
      case Error<ForgetPasswordResponse?>():
        return Error(error: result.error);
    }
  }
}
