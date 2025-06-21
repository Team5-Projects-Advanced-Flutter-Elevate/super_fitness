import 'package:injectable/injectable.dart';

import '../../../../../core/apis/api_result/api_result.dart';
import '../../../data/models/forget_password/forget_password_response.dart';
import '../../repositories_contracts/forget_password/forget_password_repo.dart';

@injectable
class ResetPasswordUseCase {
  ForgetPasswordRepo resetPasswordRepo;
  @factoryMethod
  ResetPasswordUseCase(this.resetPasswordRepo);
  Future<ApiResult<ForgetPasswordResponse?>> call(
    String email,
    String newPassword,
  ) => resetPasswordRepo.resetPassword(email, newPassword);
}
