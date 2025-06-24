import 'package:injectable/injectable.dart';

import '../../../../../core/apis/api_result/api_result.dart';
import '../../../data/models/forget_password/forget_password_response.dart';
import '../../repositories_contracts/forget_password/forget_password_repo.dart';

@injectable
class ForgetPasswordUseCase {
  ForgetPasswordRepo forgetPasswordRepo;
  @factoryMethod
  ForgetPasswordUseCase(this.forgetPasswordRepo);
  Future<ApiResult<ForgetPasswordResponse?>> call(String email) {
    return forgetPasswordRepo.forgetPassword(email);
  }
}
