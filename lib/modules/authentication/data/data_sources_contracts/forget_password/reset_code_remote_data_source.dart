import '../../../../../core/apis/api_result/api_result.dart';
import '../../models/forget_password/forget_password_response.dart';

abstract class ResetCodeRemoteDataSource {
  Future<ApiResult<ForgetPasswordResponse?>> resetCode(String code);
}
