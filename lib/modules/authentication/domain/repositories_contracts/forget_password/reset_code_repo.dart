import '../../../../../core/apis/api_result/api_result.dart';
import '../../../data/models/forget_password/forget_password_response.dart';

abstract class ResetCodeRepo {
  Future<ApiResult<ForgetPasswordResponse?>> resetCode(String code);
}
