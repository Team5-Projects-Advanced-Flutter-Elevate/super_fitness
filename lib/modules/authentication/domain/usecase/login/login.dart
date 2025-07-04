import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/modules/authentication/domain/entities/login/login_data_response_entity.dart';
import 'package:super_fitness/modules/authentication/domain/repo/login/login.dart';

@injectable
class LoginUseCase {
  final LoginRepo _loginRepo;

  LoginUseCase(this._loginRepo);

  Future<ApiResult<LoginEntity>> call(String email, String password) {
    return _loginRepo.login(email, password);
  }
}
