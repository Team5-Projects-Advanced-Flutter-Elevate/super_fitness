import 'package:injectable/injectable.dart';
import 'package:super_fitness/modules/authentication/data/data_sources_contracts/login/login_local.dart';
import 'package:super_fitness/modules/authentication/domain/repo/login/login_local.dart';

import '../../../domain/entities/login/login_data_response_entity.dart';

@Injectable(as: StoreLoginLocalRepo)
class StoreLoginLocalRepoImpl implements StoreLoginLocalRepo {
  final StoreLoginLocalDataSource _localDataSource;

  StoreLoginLocalRepoImpl(this._localDataSource);

  @override
  Future<void> saveLoginData(LoginEntity loginEntity) {
    return _localDataSource.saveLoginData(loginEntity);
  }

  @override
  Future<LoginEntity?> getLoginData() {
    return _localDataSource.getLoginData();
  }

  @override
  Future<void> clearLoginData() {
    return _localDataSource.clearLoginData();
  }
}
