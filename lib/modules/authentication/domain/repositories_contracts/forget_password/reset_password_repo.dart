import '../../../../../core/apis/api_result/api_result.dart';
import '../../../data/models/forget_password/forget_password_response.dart';

abstract class ResetPasswordRepo {
  Future<ApiResult<ForgetPasswordResponse?>> resetPassword(
    String email,
    String newPassword,
  );
}
