import 'package:injectable/injectable.dart';
import 'package:super_fitness/modules/authentication/domain/repo/login/login_local.dart';

import '../../entities/login/login_data_response_entity.dart';

@injectable
class StoreLoginLocalUseCase {
  final StoreLoginLocalRepo _loginLocalRepo;

  StoreLoginLocalUseCase(this._loginLocalRepo);

  Future<void> call(LoginEntity loginEntity) {
    return _loginLocalRepo.saveLoginData(loginEntity);
  }

  Future<LoginEntity?> getLocalData() {
    return _loginLocalRepo.getLoginData();
  }

  Future<void> clear() {
    return _loginLocalRepo.clearLoginData();
  }
}
