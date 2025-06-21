import '../../../../../core/apis/api_result/api_result.dart';
import '../../models/forget_password/forget_password_response.dart';

abstract class ForgetPasswordRemoteDataSource {
  Future<ApiResult<ForgetPasswordResponse?>> forgetPassword(String email);
  Future<ApiResult<ForgetPasswordResponse?>> resetPassword(
    String email,
    String newPassword,
  );
  Future<ApiResult<ForgetPasswordResponse?>> resetCode(String code);
}
