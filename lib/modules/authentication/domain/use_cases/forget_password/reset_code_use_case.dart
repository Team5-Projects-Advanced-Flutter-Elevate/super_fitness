import 'package:injectable/injectable.dart';

import '../../../../../core/apis/api_result/api_result.dart';
import '../../../data/models/forget_password/forget_password_response.dart';
import '../../repositories_contracts/forget_password/reset_code_repo.dart';

@injectable
class ResetCodeUseCase {
  ResetCodeRepo resetCodeRepo;
  @factoryMethod
  ResetCodeUseCase(this.resetCodeRepo);
  Future<ApiResult<ForgetPasswordResponse?>> call(String code) =>
      resetCodeRepo.resetCode(code);
}
