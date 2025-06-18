import 'package:injectable/injectable.dart';
import '../../../../../core/apis/api_executor/api_executor.dart';
import '../../../../../core/apis/api_result/api_result.dart';
import '../../api/api_client/auth_api_client.dart';
import '../../data_sources_contracts/forget_password/reset_code_remote_data_source.dart';
import '../../models/forget_password/forget_password_response.dart';
import '../../models/forget_password/user.dart';

@Injectable(as: ResetCodeRemoteDataSource)
class ResetCodeRemoteDataSourceImpl extends ResetCodeRemoteDataSource {
  AuthApiClient apiClient;
  @factoryMethod
  ResetCodeRemoteDataSourceImpl(this.apiClient);
  @override
  Future<ApiResult<ForgetPasswordResponse?>> resetCode(String code) async {
    var result = await ApiExecutor.executeApi(() async {
      var response = await apiClient.resetCode(User(resetCode: code).toJson());
      return response;
    });
    switch (result) {
      case Success<ForgetPasswordResponse?>():
        return Success(data: result.data);
      case Error<ForgetPasswordResponse?>():
        return Error(error: result.error);
    }
  }
}
